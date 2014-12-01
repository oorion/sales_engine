require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader :merchant, :parent

  def setup
    @data = {
      id: '1',
      name: 'Schroeder-Jerde',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    }
    @parent = Minitest::Mock.new
    @merchant = Merchant.new(@data, parent)
  end


  def test_it_has_attributes
    assert_equal 1, merchant.id
    assert_equal "Schroeder-Jerde", merchant.name
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_it_delegates_invoices_to_its_repository
  parent.expect(:find_invoices, nil, [1])
  merchant.invoices
  parent.verify
  end

  def test_it_delegates_items_to_its_repository
    parent.expect(:find_items, nil, [1])
    merchant.items
    parent.verify
  end
end
