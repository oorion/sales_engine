require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  def test_it_has_attributes
    data = {
      id: '1',
      name: 'Item Qui Esse',
      description: 'Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.',
      unit_price: '75107',
      merchant_id: '1',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    }

    entry = Item.new(data)
    assert_equal "1", entry.id
    assert_equal "Item Qui Esse", entry.name
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", entry.description
    assert_equal '75107', entry.unit_price
    assert_equal "1", entry.merchant_id
    assert_equal "2012-03-27 14:53:59 UTC", entry.created_at
    assert_equal "2012-03-27 14:53:59 UTC", entry.updated_at
  end
end
