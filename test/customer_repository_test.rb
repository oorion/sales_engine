require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository

  def setup
    data = [{
      id: '23',
      first_name: 'fistname',
      last_name: 'lastname',
      created_at: '2012-11-28',
      updated_at: '2014-10-15'
      },
      {
        id: '33',
        first_name: 'somename',
        last_name: 'othername',
        created_at: '2024-11-28',
        updated_at: '2024-10-15'
      },
      {
        id: '23',
        first_name: 'firstname',
        last_name: 'lastname',
        created_at: '2012-11-28',
        updated_at: '2014-10-15'
      }
      ].collect { |row| Customer.new(row) }
      @customer_repository = CustomerRepository.new(data)
  end

  def test_it_has_a_collection_of_customer_objects
    assert_instance_of Array, customer_repository.entries
    assert_instance_of Customer, customer_repository.entries[0]
  end

  def test_it_can_return_all_customers
    assert_equal 3, customer_repository.all.count
  end

  def test_it_can_return_random_customers
    assert_instance_of Customer, customer_repository.random
  end

  def test_it_can_find_by_id
    assert_equal "33", customer_repository.find_by_id("33").id
  end

  def test_it_can_find_by_first_name
    assert_equal "somename",
    customer_repository.find_by_first_name("somename").first_name
  end
end
