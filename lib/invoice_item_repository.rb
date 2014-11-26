require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :entries

  def initialize(entries = [])
    @entries = entries
  end
end
