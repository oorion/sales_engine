require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_has_a_collection_of_invoice_items
    data = [{
      id: '1',
      item_id: '539',
      invoice_id: '1',
      quantity: '5',
      unit_price: '13635',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }].collect { |row| InvoiceItem.new(row) }
    invoice_item_repository = InvoiceItemRepository.new(data)
    assert_instance_of Array, invoice_item_repository.entries
    assert_instance_of InvoiceItem, invoice_item_repository.entries[0]
  end
end
