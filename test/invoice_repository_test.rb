require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repository, :sales_engine

  def setup
    @data = [
      {
        id: "1",
        customer_id: "1",
        merchant_id: "26",
        status: "shipped",
        created_at: "2012-03-25 09:54:09 UTC",
        updated_at: "2012-03-25 09:54:09 UTC"
      },
      {
        id: "2",
        customer_id: "2",
        merchant_id: "27",
        status: "",
        created_at: "2012-04-25 09:54:09 UTC",
        updated_at: "2012-04-25 09:54:09 UTC"
      },
      {
        id: "1",
        customer_id: "1",
        merchant_id: "26",
        status: "shipped",
        created_at: "2012-03-25 09:54:09 UTC",
        updated_at: "2012-03-25 09:54:09 UTC"
      }]
      @sales_engine = Minitest::Mock.new
      @invoice_repository = InvoiceRepository.new(@data, sales_engine)
  end

  def test_it_has_a_collection_of_invoice_objects
    assert_instance_of Array, invoice_repository.entries
    assert_instance_of Invoice, invoice_repository.entries.first
  end

  def test_can_create_entries
    entries = invoice_repository.create_entries(@data)
  end

  def test_can_return_all_invoices
    assert_equal 3, invoice_repository.all.count
  end

  def test_can_return_random_invoice
    assert_instance_of Invoice, invoice_repository.random
  end

  def test_can_find_by_id
    assert_equal '1', invoice_repository.find_by_id('1').id
  end

  def test_can_find_by_customer_id
    assert_equal '1', invoice_repository.find_by_customer_id('1').customer_id
  end

  def test_can_find_by_merchant_id
    assert_equal '26', invoice_repository.find_by_merchant_id('26').merchant_id
  end

  def test_can_find_by_status
    assert_equal 'shipped', invoice_repository.find_by_status('shipped').status
  end

  def test_can_find_by_created_at
    assert_equal '2012-03-25 09:54:09 UTC',
    invoice_repository.find_by_created_at('2012-03-25 09:54:09 UTC').created_at
  end

  def test_can_find_by_created_at_with_lower_case
    assert_equal '2012-03-25 09:54:09 UTC',
    invoice_repository.find_by_created_at('2012-03-25 09:54:09 utc').created_at
  end

  def test_can_find_by_updated_at
    assert_equal '2012-03-25 09:54:09 UTC',
    invoice_repository.find_by_updated_at('2012-03-25 09:54:09 UTC').updated_at
  end

  def test_can_find_all_by_id
    assert_equal 2, invoice_repository.find_all_by_id('1').count
  end

  def test_it_returns_empty_array_if_nothing_found_using_find_all_by_id
    assert_equal [], invoice_repository.find_all_by_id('3')
  end

  def test_can_find_all_by_customer_id
    assert_equal 2, invoice_repository.find_all_by_customer_id('1').count
  end

  def test_can_find_all_by_merchant_id
    assert_equal 2, invoice_repository.find_all_by_merchant_id('26').count
  end

  def test_can_find_all_by_status
    assert_equal 2, invoice_repository.find_all_by_status('shipped').count
  end

  def test_can_find_all_by_created_at
    assert_equal 2, invoice_repository.find_all_by_created_at('2012-03-25 09:54:09 UTC').count
  end

  def test_can_find_all_by_updated_at
    assert_equal 2, invoice_repository.find_all_by_updated_at('2012-03-25 09:54:09 UTC').count
  end

  def test_it_delegates_transactions_to_sales_engine
    sales_engine.expect(:find_transactions_from_transaction_repository , nil, ["1"])
    invoice_repository.find_transactions("1")
    sales_engine.verify
  end

  def test_it_delegates_invoice_items_to_sales_engine
    sales_engine.expect(:find_invoice_items_from_invoice_item_repository , nil, ["1"])
    invoice_repository.find_invoice_items("1")
    sales_engine.verify
  end

  def test_it_delegates_items_to_sales_engine
    sales_engine.expect(:find_items_by_way_of_invoice_item_repository , nil, ["1"])
    invoice_repository.find_items("1")
    sales_engine.verify
  end

  def test_it_delegates_customer_to_sales_engine
    sales_engine.expect(:find_customer_from_customer_repository , nil, ["1"])
    invoice_repository.find_customer("1")
    sales_engine.verify
  end

  def test_it_delegates_merchant_to_sales_engine
    sales_engine.expect(:find_merchant_from_merchant_repository , nil, ["26"])
    invoice_repository.find_merchant("26")
    sales_engine.verify
  end
end
