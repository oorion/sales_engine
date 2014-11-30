require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  attr_reader :transaction, :parent

  def setup
    data = {
      id: '1',
      invoice_id: '1',
      credit_card_number: '4540842003561938',
      credit_card_expiration_date: '2014-11-25',
      result: 'success',
      created_at: '2012-11-28',
      updated_at: '2014-10-15'
    }
    @parent = Minitest::Mock.new
    @transaction = Transaction.new(data, parent)
  end

  def test_it_has_attributes
    assert_equal "1", transaction.id
    assert_equal "1", transaction.invoice_id
    assert_equal "4540842003561938", transaction.credit_card_number
    assert_equal "2014-11-25", transaction.credit_card_expiration_date
    assert_equal "success", transaction.result
    assert_equal "2012-11-28", transaction.created_at
    assert_equal "2014-10-15", transaction.updated_at
  end

  def test_it_delegates_an_invoice_to_its_repository
    parent.expect(:find_invoice, nil, ['1'])
    transaction.invoice
    parent.verify
  end
end
