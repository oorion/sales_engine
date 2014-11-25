require_relative 'test_helper'
require_relative '../lib/transaction'
require 'csv'

class TransactionTest < MiniTest::Test
  def test_it_has_attributes
    file_path = File.expand_path('./fixtures/transaction_fixture.csv', __dir__)
    csv = CSV.open(file_path, headers: true, header_converters: :symbol)
    transaction = Transaction.new(csv.first)
    assert_equal "1", transaction.id
    assert_equal "1", transaction.invoice_id
    assert_equal "4654405418249632", transaction.credit_card_number
    assert_equal nil, transaction.credit_card_expiration_date
    assert_equal "success", transaction.result
    assert_equal "2012-03-27 14:54:09 UTC", transaction.created_at
    assert_equal "2012-03-27 14:54:09 UTC", transaction.updated_at
  end
end
