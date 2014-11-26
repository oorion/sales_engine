require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_has_a_collection_of_invoice_objects
    data = [{
      id: "1",
      customer_id: "1",
      merchant_id: "26",
      status: "shipped",
      created_at: "2012-03-25 09:54:09 UTC",
      updated_at: "2012-03-25 09:54:09 UTC"
    }].collect { |row| Invoice.new(row) }

    invoice_repository = InvoiceRepository.new(data)
    assert_instance_of Array, invoice_repository.entries
    assert_instance_of Invoice, invoice_repository.entries[0]
  end
end
