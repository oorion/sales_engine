require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  attr_reader :invoice, :parent

  def setup
    @data = {
      id: "1",
      customer_id: "1",
      merchant_id: "26",
      status: "shipped",
      created_at: "2012-03-25 09:54:09 UTC",
      updated_at: "2012-03-25 09:54:09 UTC"
    }
    @parent = Minitest::Mock.new
    @invoice = Invoice.new(@data, parent)
  end

  def test_it_has_attributes
    assert_equal "1", invoice.id
    assert_equal "1", invoice.customer_id
    assert_equal "26", invoice.merchant_id
    assert_equal "shipped", invoice.status
    assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
    assert_equal "2012-03-25 09:54:09 UTC", invoice.updated_at
  end

  def test_it_delegates_transactions_to_its_repository
    parent.expect(:find_transactions, nil, ["1"])
    invoice.transactions
    parent.verify
  end

  def test_it_delegates_invoice_items_to_its_repository
    parent.expect(:find_invoice_items, nil, ["1"])
    invoice.invoice_items
    parent.verify
  end

  def test_it_delegates_items_to_its_repository
    parent.expect(:find_items, nil, ["1"])
    invoice.items
    parent.verify
  end

  def test_it_delegates_customer_to_its_repository
    parent.expect(:find_customer, nil, ["1"])
    invoice.customer
    parent.verify
  end

  def test_it_delegates_merchant_to_its_repository
    parent.expect(:find_merchant, nil, ["26"])
    invoice.merchant
    parent.verify
  end
end
