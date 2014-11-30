require_relative 'test_helper'
require_relative '../lib/sales_engine'


class IntegrationTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new('test/fixtures/')
  end

  def test_can_find_and_convert_item_ids_to_items
    invoice = sales_engine.invoice_repository.entries.first
    invoice_items = invoice.items
    assert_equal 1, invoice_items.count
    assert_instance_of Array, invoice_items
    assert_instance_of Item, invoice_items.first
  end
end
