require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repository, :sales_engine

  def setup
    @data = [{
      id: '50',
      invoice_id: '50',
      credit_card_number: '4540842003561938',
      credit_card_expiration_date: '2014-11-25',
      result: 'success',
      created_at: '2012-11-28',
      updated_at: '2014-10-15'
      },
      {
        id: '49',
        invoice_id: '49',
        credit_card_number: '4540842003561940',
        credit_card_expiration_date: '2014-11-26',
        result: 'success',
        created_at: '2012-11-18',
        updated_at: '2014-10-25'
      },
      {
        id: '50',
        invoice_id: '50',
        credit_card_number: '4540842003561938',
        credit_card_expiration_date: '2014-11-25',
        result: 'success',
        created_at: '2012-11-28',
        updated_at: '2014-10-15'
      }]
      @sales_engine = Minitest::Mock.new
      @transaction_repository = TransactionRepository.new(@data, sales_engine)
  end

  def test_it_has_a_collection_of_transaction_objects
    assert_instance_of Array, transaction_repository.entries
    assert_instance_of Transaction, transaction_repository.entries[0]
  end

  def test_can_create_entries
    entries = transaction_repository.create_entries(@data)
    assert_instance_of Array, entries
    assert_instance_of Transaction, entries[0]
  end

  def test_can_return_all_transactions
    assert_equal 3, transaction_repository.all.count
  end

  def test_can_return_a_random_transaction
    assert_instance_of Transaction, transaction_repository.random
  end

  def test_can_find_by_id
    assert_equal '50', transaction_repository.find_by_id('50').id
  end

  def test_can_find_by_invoice_id
    assert_equal '49', transaction_repository.find_by_invoice_id('49').invoice_id
  end

  def test_can_find_by_credit_card_number
    assert_equal '4540842003561938',
    transaction_repository.find_by_credit_card_number('4540842003561938').credit_card_number
  end

  def test_can_find_by_credit_card_expiration_date
    assert_equal '2014-11-25',
    transaction_repository.find_by_credit_card_expiration_date('2014-11-25').credit_card_expiration_date
  end

  def test_can_find_by_result
    assert_equal 'success', transaction_repository.find_by_result('success').result
  end

  def test_can_find_by_created_at
    assert_equal '2012-11-28', transaction_repository.find_by_created_at('2012-11-28').created_at
  end

  def test_can_find_by_updated_at
    assert_equal '2014-10-25', transaction_repository.find_by_updated_at('2014-10-25').updated_at
  end

  def test_can_find_all_by_id
    assert_equal 2, transaction_repository.find_all_by_id('50').count
  end

  def test_can_find_all_by_credit_card_number
    assert_equal 2,
    transaction_repository.find_all_by_credit_card_number('4540842003561938').count
  end

  def test_can_find_all_by_credit_card_expiration_date
    assert_equal 2,
    transaction_repository.find_all_by_credit_card_expiration_date('2014-11-25').count
  end

  def test_can_find_all_by_result
    assert_equal 3, transaction_repository.find_all_by_result('success').count
  end

  def test_can_find_all_by_created_at
    assert_equal 2, transaction_repository.find_all_by_created_at('2012-11-28').count
  end

  def test_can_find_all_by_updated_at
    assert_equal 1, transaction_repository.find_all_by_updated_at('2014-10-25').count
  end

end
