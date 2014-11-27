require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
    attr_reader :merchant_repository

    def setup
      data = [
        {
          id: '1',
          name: 'Schroeder-Jerde',
          created_at: '2012-03-27 14:53:59 UTC',
          updated_at: '2012-03-27 14:53:59 UTC'
    },
        {
          id: '2',
          name: 'Picasso',
          created_at: '2012-03-26 12:43:01 UTC',
          updated_at: '2012-03-26 12:43:01 UTC'
    },
        {
          id: '1',
          name: 'Schroeder-Jerde',
          created_at: '2012-03-27 14:53:59 UTC',
          updated_at: '2012-03-27 14:53:59 UTC'
    }].collect { |row| Merchant.new(row) }

    @merchant_repository = MerchantRepository.new(data)
  end

  def test_it_has_a_collection_of_merchant_objects
    assert_instance_of Array, merchant_repository.entries
    assert_instance_of Merchant, merchant_repository.entries[0]
  end

  def test_can_return_all_merchants
    assert_equal 3, merchant_repository.all.count
  end

  def test_can_reutrn_random_invoices
    assert_instance_of Merchant, merchant_repository.random
  end

  def test_can_find_by_id
    assert_equal '1', merchant_repository.find_by_id('1').id
  end

  def test_can_find_by_name
    assert_equal 'Schroeder-Jerde', merchant_repository.find_by_name('Schroeder-Jerde').name
  end

  def test_can_find_by_created_at
    assert_equal '2012-03-27 14:53:59 UTC',
    merchant_repository.find_by_created_at('2012-03-27 14:53:59 UTC').created_at
  end

  def test_can_find_by_created_at_with_lower_case
    assert_equal '2012-03-27 14:53:59 UTC',
    merchant_repository.find_by_created_at('2012-03-27 14:53:59 utc').created_at
  end

  def test_can_find_by_updated_at
    assert_equal '2012-03-27 14:53:59 UTC',
    merchant_repository.find_by_updated_at('2012-03-27 14:53:59 UTC').updated_at
  end
end
