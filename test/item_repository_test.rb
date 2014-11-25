require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < MiniTest::Test
  def test_it_has_a_collection_of_item_objects
    data = [{
      id: '1',
      name: 'Item Qui Esse',
      description: 'Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.',
      unit_price: '75107',
      merchant_id: '1',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    }].collect { |row| Item.new(row) }
    item_repository = ItemRepository.new(data)
    assert_instance_of Array, item_repository.entries
    assert_instance_of Item, item_repository.entries[0]
  end
end
