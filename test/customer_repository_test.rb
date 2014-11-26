require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def test_it_has_a_collection_of_customer_objects
    data = [{
      id: '23',
      first_name: 'fistname',
      last_name: 'lastname',
      created_at: '2012-11-28',
      updated_at: '2014-10-15'
    }].collect { |row| Customer.new(row) }

    customer_repository = CustomerRepository.new(data)
    assert_instance_of Array, customer_repository.entries
    assert_instance_of Customer, customer_repository.entries[0]
  end

    def test_it_can_find_by_first_name
      data = [{
        id: '1',
        first_name: 'Joey',
        last_name: 'Ondricka',
        created_at: '2012-03-27 14:54:09 UTC',
        updated_at: '2012-03-27 14:54:09 UTC'},{
        id: '2',
        first_name: 'Cecelia',
        last_name: 'Osinski',
        created_at: '2012-03-27 14:54:10 UTC',
        updated_at: '2012-03-27 14:54:10 UTC'
          }].collect { |row| Customer.new(row) }
    customer_repository = CustomerRepository.new(data)
    assert_equal 'Joey', customer_repository.find_by_first_name('Joey')
  end
end
