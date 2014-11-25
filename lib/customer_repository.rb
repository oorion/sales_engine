require_relative 'customer'

class CustomerRepository
  attr_reader :entries

  def initialize(entries=[])
    @entries = entries
  end
end
