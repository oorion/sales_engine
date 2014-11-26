require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_attributes
    data = {
      id: '1',
      name: 'Schroeder-Jerde',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    }

    entry = Merchant.new(data)
    assert_equal "1", entry.id
    assert_equal "Schroeder-Jerde", entry.name
    assert_equal "2012-03-27 14:53:59 UTC", entry.created_at
    assert_equal "2012-03-27 14:53:59 UTC", entry.updated_at
  end
end
