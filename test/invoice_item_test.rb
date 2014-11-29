require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item, :parent

  def setup
    @data = {
      id: '1',
      item_id: '539',
      invoice_id: '1',
      quantity: '5',
      unit_price: '13635',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }
    @parent = Minitest::Mock.new
    @invoice_item = InvoiceItem.new(@data, parent)

  end

  def test_it_has_attributes
    assert_equal '1', invoice_item.id
    assert_equal '539', invoice_item.item_id
    assert_equal '1', invoice_item.invoice_id
    assert_equal '5', invoice_item.quantity
    assert_equal '13635', invoice_item.unit_price
    assert_equal '2012-03-27 14:54:09 UTC', invoice_item.created_at
    assert_equal '2012-03-27 14:54:09 UTC', invoice_item.updated_at
  end

  def test_delegates_invoice_to_its_repository
    parent.expect(:find_invoice, nil, ['1'])
    invoice_item.invoice
    parent.verify
  end

  def test_delegates_item_to_its_repository
    parent.expect(:find_item, nil, ['539'])
    invoice_item.item
    parent.verify
  end
end
