require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository

  def setup
    data = [
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
        created_at: '2012-03-27 14:53:59 UTC',
        updated_at: '2012-03-27 14:53:59 UTC'
      }
      ].collect { |row| Item.new(row) }
      @item_repository = ItemRepository.new(data)
  end

  def test_it_has_a_collection_of_item_objects
    assert_instance_of Array, item_repository.entries
    assert_instance_of Item, item_repository.entries[0]
  end

  def test_can_return_all_items
    assert_equal 2, item_repository.all.count
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

  def test_can_find_by_updated_at
    assert_equal '2012-03-27 14:53:59 UTC',
    item_repository.find_by_updated_at('2012-03-27 14:53:59 UTC').updated_at
  end
end
