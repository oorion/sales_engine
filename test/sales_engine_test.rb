require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new('test/fixtures/')
  end

  def test_has_a_repositories_with_a_collection_of_entries
    assert_instance_of MerchantRepository, sales_engine.merchant_repository
    assert_instance_of Merchant, sales_engine.merchant_repository.entries[0]

    assert_instance_of InvoiceRepository, sales_engine.invoice_repository
    assert_instance_of Invoice, sales_engine.invoice_repository.entries[0]

    assert_instance_of ItemRepository, sales_engine.item_repository
    assert_instance_of Item, sales_engine.item_repository.entries[0]

    assert_instance_of InvoiceItemRepository, sales_engine.invoice_item_repository
    assert_instance_of InvoiceItem, sales_engine.invoice_item_repository.entries[0]

    assert_instance_of CustomerRepository, sales_engine.customer_repository
    assert_instance_of Customer, sales_engine.customer_repository.entries[0]

    assert_instance_of TransactionRepository, sales_engine.transaction_repository
    assert_instance_of Transaction, sales_engine.transaction_repository.entries[0]
  end

  def test_delegates_find_invoices_from_invoice_repository_to_invoice_repository
    @sales_engine.invoice_repository = Minitest::Mock.new
    sales_engine.invoice_repository.expect(:find_invoices, nil, ['1'])
    sales_engine.find_invoices_from_invoice_repository('1')
    sales_engine.invoice_repository.verify
  end

  def test_assigns_responsibility_of_retrieving_merchant_invoices_to_invoice_repository
    @sales_engine.invoice_repository = Minitest::Mock.new
    sales_engine.invoice_repository.expect(:find_merchant_invoices, nil, ['2'])
    sales_engine.find_merchant_invoices_from_invoice_repository('2')
    sales_engine.invoice_repository.verify
  end

  def test_assigns_responsibility_of_retrieving_transaction_invoice_to_invoice_repository
    @sales_engine.invoice_repository = Minitest::Mock.new
    sales_engine.invoice_repository.expect(:find_transaction_invoice, nil, ['1'])
    sales_engine.find_transaction_invoice_from_invoice_repository('1')
    sales_engine.invoice_repository.verify
  end

  def test_delegates_find_invoice_items_from_invoice_item_repository_to_invoice_item_repository
    sales_engine.invoice_item_repository = Minitest::Mock.new
    sales_engine.invoice_item_repository.expect(:find_all_by_item_id, nil, ['1'])
    sales_engine.find_invoice_items_from_invoice_item_repository('1')
    sales_engine.invoice_item_repository.verify
  end

  def test_delegates_find_merchant_from_merchant_repository_to_merchant_repository
    sales_engine.merchant_repository = Minitest::Mock.new
    sales_engine.merchant_repository.expect(:find_by_id, nil, ['1'])
    sales_engine.find_merchant_from_merchant_repository('1')
    sales_engine.merchant_repository.verify
  end

  def test_delgates_find_items_from_item_repository_to_item_repository
    @sales_engine.item_repository = Minitest::Mock.new
    sales_engine.item_repository.expect(:find_items, nil, ['1'])
    sales_engine.find_items_from_item_repository('1')
    sales_engine.item_repository.verify
  end


end
