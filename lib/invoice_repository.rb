require_relative 'invoice'

class InvoiceRepository
  attr_reader :entries
  
  def initialize(entries = [])
    @entries = entries
  end
end
