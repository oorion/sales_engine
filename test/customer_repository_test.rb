require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def test_it_has_a_collection_of_customer_objects
    data = [{
      id: '23',
      name: 'newname',
      created_at: '2012-11-28',
      updated_at: '2014-10-15'
    }].collect { |row| Customer.new(row) }

    customer_repository = CustomerRepository.new(data)
    assert_instance_of Array, customer_repository.entries
    assert_instance_of Customer, customer_repository.entries[0]  
  end
end
