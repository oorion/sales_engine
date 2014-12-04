require_relative 'test_helper'
require_relative '../lib/sales_engine'

class IntegrationTest < Minitest::Test
  attr_reader :sales_engine, :production_sales_engine

  def setup
    @sales_engine ||= SalesEngine.new('test/fixtures/')
    @sales_engine.startup
    @production_sales_engine ||= SalesEngine.new
    @production_sales_engine.startup
  end

  def test_can_find_and_convert_item_ids_to_items
    invoice = sales_engine.invoice_repository.entries.first
    invoice_items = invoice.items
    assert_equal 1, invoice_items.count
    assert_instance_of Array, invoice_items
    assert_instance_of Item, invoice_items.first
  end

  def test_it_can_find_the_merchant_with_the_most_revenue
    skip
    assert_equal "Dicki-Bednar", production_sales_engine.merchant_repository.most_revenue(1).first.name
    assert_equal ["Dicki-Bednar", "Kassulke, O'Hara and Quitzon"], production_sales_engine.merchant_repository.most_revenue(2).map { |merchant| merchant.name }
  end

  def test_merchant_can_calculate_revenue
    assert_equal (BigDecimal.new('29973') / 100) * 6, sales_engine.merchant_repository.entries.last.revenue
  end

  def test_merchant_can_calculate_revenue_by_date
    assert_equal (BigDecimal.new('29973') / 100) * 6, sales_engine.merchant_repository.entries.last.revenue(Date.parse('2012-03-07 12:54:10 UTC'))
  end

  def test_merchant_can_find_favorite_customer
    assert_equal 7, production_sales_engine.merchant_repository.entries.first.favorite_customer.id
  end

  def test_merchant_can_find_customers_with_pending_invoices
    assert_equal 3, production_sales_engine.merchant_repository.entries.first.customers_with_pending_invoices.length
  end

  def test_merchant_repository_can_find_most_items_sold
    assert_equal 1, production_sales_engine.merchant_repository.most_items(1).length
    assert_equal ["Kassulke, O'Hara and Quitzon", "Kozey Group", "Thiel Inc"], production_sales_engine.merchant_repository.most_items(3).map { |merchant| merchant.name }
  end

  def test_merchant_repository_can_find_total_revenue_by_date_for_all_merchants
    assert_equal BigDecimal.new('190836805') / 100, production_sales_engine.merchant_repository.revenue(Date.parse("2012-03-27 14:54:09 UTC"))
  end

  def test_create_method_creates_a_new_invoice
    customer = sales_engine.customer_repository.entries[0]
    merchant = sales_engine.merchant_repository.entries[0]
    item1    = sales_engine.item_repository.entries[0]
    item2    = sales_engine.item_repository.entries[1]
    item3    = sales_engine.item_repository.entries[2]
    invoice = sales_engine.invoice_repository.create({customer: customer, merchant: merchant, status: "shipped", items: [item1, item2, item3]})
    assert_equal customer, invoice.customer
    assert_equal merchant, invoice.merchant
    assert_equal "shipped", invoice.status
  end

  def test_entries_has_a_new_invoice
    customer = sales_engine.customer_repository.entries[0]
    merchant = sales_engine.merchant_repository.entries[0]
    item1    = sales_engine.item_repository.entries[0]
    item2    = sales_engine.item_repository.entries[1]
    item3    = sales_engine.item_repository.entries[2]
    invoice = sales_engine.invoice_repository.create({customer: customer, merchant: merchant, status: "shipped", items: [item1, item2, item3]})
    assert_equal 1, sales_engine.invoice_repository.entries.last.customer.id
  end

  def test_the_invoice_format_is_correct
    customer = sales_engine.customer_repository.entries[0]
    merchant = sales_engine.merchant_repository.entries[0]
    item1    = sales_engine.item_repository.entries[0]
    item2    = sales_engine.item_repository.entries[1]
    item3    = sales_engine.item_repository.entries[2]
    invoice = sales_engine.invoice_repository.create({customer: customer, merchant: merchant, status: "shipped", items: [item1, item2, item3]})
    assert_equal 11, sales_engine.invoice_repository.entries.last.id
    assert_equal 1, sales_engine.invoice_repository.entries.last.customer_id
    assert_equal 1, sales_engine.invoice_repository.entries.last.merchant_id
    assert_equal "shipped", sales_engine.invoice_repository.entries.last.status
    assert sales_engine.invoice_repository.entries.last.created_at
    assert sales_engine.invoice_repository.entries.last.updated_at
  end

  def test_it_creates_a_new_invoice_item
    item1    = sales_engine.item_repository.entries[0]
    item2    = sales_engine.item_repository.entries[1]
    item3    = sales_engine.item_repository.entries[2]
    invoice_items = sales_engine.invoice_item_repository.create_invoice_item({items: [item1, item2, item3]})
    assert_equal 13, sales_engine.invoice_item_repository.entries.last.id
  end

  def test_it_creates_an_invoice_item
    customer = sales_engine.customer_repository.entries[0]
    merchant = sales_engine.merchant_repository.entries[0]
    item1    = sales_engine.item_repository.entries[0]
    item2    = sales_engine.item_repository.entries[1]
    item3    = sales_engine.item_repository.entries[2]
    invoice = sales_engine.invoice_repository.create({customer: customer,
                                                      merchant: merchant,
                                                      status: "shipped",
                                                      items: [item1, item2, item3]})
    assert_equal 3, sales_engine.invoice_item_repository.entries.last.item_id
  end
end
