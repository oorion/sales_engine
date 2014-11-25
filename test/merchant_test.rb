require_relative 'test_helper'
require_relative '../lib/merchant'
require 'csv'

class MerchantTest < MiniTest::Test
    def test_it_has_attributes
      file_path = File.expand_path('./fixtures/merchant_fixture.csv', __dir__)
      csv = CSV.open(file_path, headers: true, header_converters: :symbol)
      merchant = Merchant.new(csv.first)
      assert_equal "1", merchant.id
      assert_equal "Schroeder-Jerde", merchant.name
      assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
      assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
    end
end
