require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  def test_it_has_attributes
    data = {
      id: '23',
      first_name: 'firstname',
      last_name: 'lastname',
      created_at: '2012-11-28',
      updated_at: '2014-10-15'
    }
    customer = Customer.new(data)
    assert_equal '23', customer.id
    assert_equal 'firstname', customer.first_name
    assert_equal 'lastname', customer.last_name
    assert_equal '2012-11-28', customer.created_at
    assert_equal '2014-10-15', customer.updated_at
  end
end
