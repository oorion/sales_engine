require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repository, :sales_engine

  def setup
    @data = [
      {
      id: '1',
      item_id: '539',
      invoice_id: '1',
      quantity: '5',
      unit_price: '13635',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
      },
      {
        id: '2',
        item_id: '540',
        invoice_id: '2',
        quantity: '6',
        unit_price: '13636',
        created_at: '2012-04-27 14:54:09 UTC',
        updated_at: '2012-04-27 14:54:09 UTC'
      },
      {
        id: '1',
        item_id: '539',
        invoice_id: '1',
        quantity: '5',
        unit_price: '13635',
        created_at: '2012-03-27 14:54:09 UTC',
        updated_at: '2012-03-27 14:54:09 UTC'
      }]
    @sales_engine = Minitest::Mock.new
    @invoice_item_repository = InvoiceItemRepository.new(@data, sales_engine)
  end

  def test_it_has_a_collection_of_invoice_items
    assert_instance_of Array, invoice_item_repository.entries
    assert_instance_of InvoiceItem, invoice_item_repository.entries[0]
  end

  def test_can_create_entries
    entries = invoice_item_repository.create_entries(@data)
    assert_instance_of Array, entries
    assert_instance_of InvoiceItem, entries[0]
  end

  def test_it_can_return_all_invoice_items
    assert_equal 3, invoice_item_repository.all.length
  end

  def test_it_can_return_a_random_invoice_item
    assert_instance_of InvoiceItem, invoice_item_repository.random
  end

  def test_can_find_by_id
    assert_equal '1', invoice_item_repository.find_by_id('1').id
  end

  def test_can_find_by_item_id
    assert_equal '539', invoice_item_repository.find_by_item_id('539').item_id
  end

  def test_can_find_by_invoice_id
    assert_equal '1', invoice_item_repository.find_by_invoice_id('1').invoice_id
  end

  def test_can_find_by_quantity
    assert_equal '5', invoice_item_repository.find_by_quantity('5').quantity
  end

  def test_can_find_by_unit_price
    assert_equal '13635', invoice_item_repository.find_by_unit_price('13635').unit_price
  end

  def test_can_find_by_created_at
    assert_equal '2012-03-27 14:54:09 UTC', invoice_item_repository.find_by_created_at('2012-03-27 14:54:09 UTC').created_at
  end

  def test_can_find_by_updated_at
    assert_equal '2012-03-27 14:54:09 UTC', invoice_item_repository.find_by_updated_at('2012-03-27 14:54:09 UTC').updated_at
  end

  def test_can_find_all_by_id
    assert_equal 2, invoice_item_repository.find_all_by_id('1').count
  end

  def test_can_return_empty_array_if_nothing_found
    assert_equal [], invoice_item_repository.find_all_by_id('3')
  end

  def test_can_find_all_by_item_id
    assert_equal 2, invoice_item_repository.find_all_by_item_id('539').count
  end

  def test_can_find_all_by_invoice_id
    assert_equal 2, invoice_item_repository.find_all_by_invoice_id('1').count
  end

  def test_can_find_all_by_quantity
    assert_equal 2, invoice_item_repository.find_all_by_quantity('5').count
  end

  def test_can_find_all_by_unit_price
    assert_equal 2, invoice_item_repository.find_all_by_unit_price('13635').count
  end

  def test_can_find_all_by_created_at
    assert_equal 2, invoice_item_repository.find_all_by_created_at('2012-03-27 14:54:09 UTC').count
  end

  def test_can_find_all_by_updated_at
    assert_equal 2, invoice_item_repository.find_all_by_updated_at('2012-03-27 14:54:09 UTC').count
  end

  def test_delegates_find_invoice_to_sales_engine
    sales_engine.expect(:find_invoice_from_invoice_repository, nil, ['1'])
    invoice_item_repository.find_invoice('1')
    sales_engine.verify
  end

  def test_delegates_find_item_to_sales_engine
    sales_engine.expect(:find_item_from_item_repository, nil, ['539'])
    invoice_item_repository.find_item('539')
    sales_engine.verify
  end

  def test_can_find_invoice_items
    assert_equal 2, invoice_item_repository.find_invoice_items('1').count
    assert_instance_of InvoiceItem, invoice_item_repository.find_invoice_items('1')[0]
  end
end
