require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_has_a_collection_of_merchant_instances
    data = [{
      id: '1',
      name: 'Schroeder-Jerde',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    }].collect { |row| Merchant.new(row) }
    merchant_repository = MerchantRepository.new(data)
    assert_instance_of Array, merchant_repository.entries
    assert_instance_of Merchant, merchant_repository.entries[0]
  end
end
