require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def test_it_has_a_collection_of_transaction_instances
    data = [{
      id: '50',
      invoice_id: '50',
      credit_card_number: '4540842003561938',
      credit_card_expiration_date: '2014-11-25',
      result: 'success',
      created_at: '2012-11-28',
      updated_at: '2014-10-15'
    }].collect { |row| Transaction.new(row) }
    transaction_repository = TransactionRepository.new(data)
    assert_instance_of Array, transaction_repository.entries
    assert_instance_of Transaction, transaction_repository.entries[0]
  end
end
