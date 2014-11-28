require_relative 'invoice_item'

class InvoiceItemRepository
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

  def find_by_item_id(match)
    entries.find { |entry| entry.item_id == match }
  end

  def find_by_invoice_id(match)
    entries.find { |entry| entry.invoice_id == match }
  end

  def find_by_quantity(match)
    entries.find { |entry| entry.quantity == match }
  end

  def find_by_unit_price(match)
    entries.find { |entry| entry.unit_price == match }
  end

  def find_by_created_at(match)
    entries.find { |entry| entry.created_at.downcase == match.downcase }
  end

  def find_by_updated_at(match)
    entries.find { |entry| entry.updated_at.downcase == match.downcase }
  end

  def find_all_by_id(match)
    entries.select { |entry| entry.id == match }
  end

  def find_all_by_item_id(match)
    entries.select { |entry| entry.item_id == match }
  end

  def find_all_by_invoice_id(match)
    entries.select { |entry| entry.invoice_id == match }
  end

  def find_all_by_quantity(match)
    entries.select { |entry| entry.quantity == match }
  end

  def find_all_by_unit_price(match)
    entries.select { |entry| entry.unit_price == match }
  end

  def find_all_by_created_at(match)
    entries.select { |entry| entry.created_at.downcase == match.downcase }
  end

  def find_all_by_updated_at(match)
    entries.select { |entry| entry.updated_at.downcase == match.downcase }
  end
end
