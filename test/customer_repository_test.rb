require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository, :sales_engine

  def setup
    @data = [{
      id: '23',
      first_name: 'firstname',
      last_name: 'lastname',
      created_at: '2012-11-28',
      updated_at: '2014-10-15'
      },
      {
        id: '33',
        first_name: 'somename',
        last_name: 'othername',
        created_at: '2024-11-29',
        updated_at: '2014-10-15'
      },
      {
        id: '23',
        first_name: 'firstname',
        last_name: 'lastname',
        created_at: '2012-11-28',
        updated_at: '2014-10-15'
      }
    ]
    @sales_engine = Minitest::Mock.new
    @customer_repository = CustomerRepository.new(@data, sales_engine)
  end

  def test_it_has_a_collection_of_customer_objects
    assert_instance_of Array, customer_repository.entries
    assert_instance_of Customer, customer_repository.entries[0]
  end

  def test_can_create_entries
    entries = customer_repository.create_entries(@data)
    assert_instance_of Array, entries
    assert_instance_of Customer, entries[0]
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

  def test_it_can_find_by_first_name_uppercase
    assert_equal "somename",
    customer_repository.find_by_first_name("Somename").first_name
  end

  def test_it_can_find_by_last_name
    assert_equal "lastname",
    customer_repository.find_by_last_name("lastname").last_name
  end

  def test_can_find_by_created_at
    assert_equal '2012-11-28',
    customer_repository.find_by_created_at('2012-11-28').created_at
  end

  def test_can_find_by_updated_at
    assert_equal '2014-10-15',
    customer_repository.find_by_updated_at('2014-10-15').updated_at
  end

  def test_can_find_all_by_id
    assert_equal 2, customer_repository.find_all_by_id('23').count
  end

  def test_can_find_all_by_first_name
    assert_equal 2,
    customer_repository.find_all_by_first_name('firstname').count
  end

  def test_can_find_all_by_last_name
    assert_equal 2,
    customer_repository.find_all_by_last_name('lastname').count
  end

  def test_can_find_all_by_created_at
    assert_equal 2,
    customer_repository.find_all_by_created_at('2012-11-28').count
  end

  def test_can_find_all_by_updated_at
    assert_equal 3,
    customer_repository.find_all_by_updated_at('2014-10-15').count
  end

  def test_it_delegates_invoices_to_sales_engine
    sales_engine.expect(:find_invoices_from_invoice_repository, nil, ["23"])
    customer_repository.find_invoices("23")
    sales_engine.verify
  end

  def test_can_find_customer
    assert_equal 2, customer_repository.find_customer('23').count
    assert_instance_of Customer, customer_repository.find_customer('23')[0]
  end
end
