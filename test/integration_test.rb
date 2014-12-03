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

  def test_customer_can_get_transactions
    assert_equal 7, SalesEngine.new.customer_repository.entries.first.transactions.length
  end

  def test_customer_can_get_favorite_merchant
    assert_equal 'blah', SalesEngine.new.customer_repository.entries.first.favorite_merchant#.name
  end
end
