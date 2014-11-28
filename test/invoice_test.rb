require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def test_it_has_attributes
    data = {
      id: "1",
      customer_id: "1",
      merchant_id: "26",
      status: "shipped",
      created_at: "2012-03-25 09:54:09 UTC",
      updated_at: "2012-03-25 09:54:09 UTC"
    }

    entry = Invoice.new(data, '')
    assert_equal "1", entry.id
    assert_equal "1", entry.customer_id
    assert_equal "26", entry.merchant_id
    assert_equal "shipped", entry.status
    assert_equal "2012-03-25 09:54:09 UTC", entry.created_at
    assert_equal "2012-03-25 09:54:09 UTC", entry.updated_at
  end

end
