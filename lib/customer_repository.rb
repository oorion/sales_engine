require_relative 'customer'

class CustomerRepository
  attr_reader :entries

  def initialize(entries=[])
    @entries = entries
  end

  def all
    entries
  end

  def random
    entries.sample
  end

  def find_by_id(match)
    entries.find { |entry| entry.id == match }
  end

  def find_by_first_name(match)
    entries.find { |entry| entry.first_name.downcase == match.downcase }
  end
end
