require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository, :sales_engine

  def setup
    @data = [
      {
      id: '1',
      name: 'name1',
      description: 'Nihil autem',
      unit_price: '75107',
      merchant_id: '1',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
      },
      {
        id: '2',
        name: 'name2',
        description: 'inventore deleniti',
        unit_price: '751',
        merchant_id: '2',
        created_at: '2012-04-27 14:53:59 UTC',
        updated_at: '2012-04-27 14:53:59 UTC'
      },
      {
        id: '1',
        name: 'name1',
        description: 'Nihil autem',
        unit_price: '75107',
        merchant_id: '1',
        created_at: '2012-03-27 14:53:59 UTC',
        updated_at: '2012-03-27 14:53:59 UTC'
      }]
      @sales_engine = Minitest::Mock.new
      @item_repository = ItemRepository.new(@data, sales_engine)
  end

  def test_it_has_a_collection_of_item_objects
    assert_instance_of Array, item_repository.entries
    assert_instance_of Item, item_repository.entries[0]
  end

  def test_can_create_entries
    entries = item_repository.create_entries(@data)
    assert_instance_of Array, entries
    assert_instance_of Item, entries[0]
  end

  def test_can_return_all_items
    assert_equal 3, item_repository.all.count
  end

  def test_can_return_random_item
    assert_instance_of Item, item_repository.random
  end

  def test_can_find_by_id
    assert_equal "1", item_repository.find_by_id('1').id
  end

  def test_can_find_by_name
    assert_equal 'name1', item_repository.find_by_name('name1').name
  end

  def test_can_find_by_name_as_uppercase
    assert_equal 'name1', item_repository.find_by_name('NAME1').name
  end

  def test_can_find_by_description
    assert_equal 'Nihil autem',
    item_repository.find_by_description('Nihil autem').description
  end

  def test_can_find_by_unit_price
    assert_equal '75107',
    item_repository.find_by_unit_price('75107').unit_price
  end

  def test_can_find_by_merchant_id
    assert_equal '1', item_repository.find_by_merchant_id('1').merchant_id
  end

  def test_can_find_by_created_at
    assert_equal '2012-03-27 14:53:59 UTC',
    item_repository.find_by_created_at('2012-03-27 14:53:59 UTC').created_at
  end

  def test_can_find_by_created_at_with_lower_case
    assert_equal '2012-03-27 14:53:59 UTC',
    item_repository.find_by_created_at('2012-03-27 14:53:59 utc').created_at
  end

  def test_can_find_by_updated_at
    assert_equal '2012-03-27 14:53:59 UTC',
    item_repository.find_by_updated_at('2012-03-27 14:53:59 UTC').updated_at
  end

  def test_can_find_all_by_id
    assert_equal 2, item_repository.find_all_by_id('1').count
  end

  def test_it_returns_empty_array_if_nothing_found_using_find_all_by_id
    assert_equal [], item_repository.find_all_by_id('3')
  end

  def test_can_find_all_by_name
    assert_equal 2, item_repository.find_all_by_name('name1').count
  end

  def test_can_find_all_by_description
    assert_equal 2, item_repository.find_all_by_description('Nihil autem').count
  end

  def test_can_find_all_by_unit_price
    assert_equal 2, item_repository.find_all_by_unit_price('75107').count
  end

  def test_can_find_all_by_merchant_id
    assert_equal 2, item_repository.find_all_by_merchant_id('1').count
  end

  def test_can_find_all_by_created_at
    assert_equal 2, item_repository.find_all_by_created_at('2012-03-27 14:53:59 UTC').count
  end

  def test_can_find_all_by_updated_at
    assert_equal 2, item_repository.find_all_by_updated_at('2012-03-27 14:53:59 UTC').count
  end

  def test_it_delegates_find_invoice_items_to_sales_engine
    sales_engine.expect(:find_item_invoice_items_from_invoice_item_repository, nil, ['1'])
    item_repository.find_invoice_items('1')
    sales_engine.verify
  end

  def test_it_delegates_find_merchant_to_sales_engine
    sales_engine.expect(:find_merchant_from_merchant_repository, nil, ['1'])
    item_repository.find_merchant('1')
    sales_engine.verify
  end
end
