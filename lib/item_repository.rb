require_relative 'item'

class ItemRepository
  attr_reader :entries

  def initialize(entries = [])
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

  def find_by_name(match)
    entries.find { |entry| entry.name == match }
  end

  def find_by_description(match)
    entries.find { |entry| entry.description == match }
  end

  def find_by_unit_price(match)
    entries.find { |entry| entry.unit_price == match }
  end

  def find_by_merchant_id(match)
    entries.find { |entry| entry.merchant_id == match }
  end

  def find_by_created_at(match)
    entries.find { |entry| entry.created_at == match }
  end

  def find_by_updated_at(match)
    entries.find { |entry| entry.updated_at == match }
  end
end
