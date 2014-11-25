require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_has_a_collection_of_merchant_instances
    merchant_repository = MerchantRepository.new('merchant_fixture.csv')
    assert_instance_of Array, merchant_repository.merchants
    assert_instance_of Merchant, merchant_repository.merchants[0]
  end
end
