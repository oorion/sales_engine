require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
    attr_reader :merchant_repository, :sales_engine

    def setup
      @data = [
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
    }]

    @sales_engine = Minitest::Mock.new
    @merchant_repository = MerchantRepository.new(@data, sales_engine)
  end

  def test_it_has_a_collection_of_merchant_objects
    assert_instance_of Array, merchant_repository.entries
    assert_instance_of Merchant, merchant_repository.entries[0]
  end

  def test_can_create_entries
      entries = merchant_repository.create_entries(@data)
      assert_instance_of Array, entries
      assert_instance_of Merchant, entries[0]
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

  def test_can_find_all_by_id
    assert_equal 2, merchant_repository.find_all_by_id('1').count
  end

  def test_it_returns_empty_array_if_nothing_found_using_find_all_by_id
    assert_equal [], merchant_repository.find_all_by_id('3')
  end

  def test_can_find_all_by_name
    assert_equal 2, merchant_repository.find_all_by_name('Schroeder-Jerde').count
  end

  def test_can_find_all_by_created_at
    assert_equal 2, merchant_repository.find_all_by_created_at('2012-03-27 14:53:59 UTC').count
  end

  def test_can_find_all_by_updated_at
    assert_equal 2, merchant_repository.find_all_by_updated_at('2012-03-27 14:53:59 UTC').count
  end

  def test_it_can_delegate_invoices_to_sales_engine
    sales_engine.expect(:find_merchant_invoices_from_invoice_repository, nil, ['1'])
    merchant_repository.find_invoices('1')
    sales_engine.verify
  end

  def test_it_can_delegate_items_to_sales_engine
    sales_engine.expect(:find_items_from_item_repository, nil, ['1'])
    merchant_repository.find_items('1')
    sales_engine.verify
  end
end
