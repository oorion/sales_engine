require_relative 'test_helper'
require_relative '../lib/transaction'
require 'csv'

class TransactionTest < Minitest::Test
  def test_it_has_attributes
    data = {
      id: '50',
      invoice_id: '50',
      credit_card_number: '4540842003561938',
      credit_card_expiration_date: '2014-11-25',
      result: 'success',
      created_at: '2012-11-28',
      updated_at: '2014-10-15'
      }
    transaction = Transaction.new(data)
    assert_equal "50", transaction.id
    assert_equal "50", transaction.invoice_id
    assert_equal "4540842003561938", transaction.credit_card_number
    assert_equal "2014-11-25", transaction.credit_card_expiration_date
    assert_equal "success", transaction.result
    assert_equal "2012-11-28", transaction.created_at
    assert_equal "2014-10-15", transaction.updated_at
  end
end
