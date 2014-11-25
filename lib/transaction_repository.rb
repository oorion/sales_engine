require_relative 'transaction'

class TransactionRepository
  attr_reader :entries

  def initialize(entries = [])
      @entries = entries
  end
end
