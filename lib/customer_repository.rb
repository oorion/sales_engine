require_relative 'customer'

class CustomerRepository
  attr_reader :entries, :sales_engine

  def initialize(entries=[], parent)
    @entries = create_entries(entries)
    @sales_engine = parent
  end

  def create_entries(entries)
    entries.collect { |row| Customer.new(row, self) }
  end

  def find_invoices(id)
    sales_engine.find_customer_invoices_from_invoice_repository(id)
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

  def find_by_last_name(match)
    entries.find { |entry| entry.last_name.downcase == match.downcase }
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

  def find_all_by_first_name(match)
    entries.select { |entry| entry.first_name.downcase == match.downcase }
  end

  def find_all_by_last_name(match)
    entries.select { |entry| entry.last_name.downcase == match.downcase }
  end

  def find_all_by_created_at(match)
    entries.select { |entry| entry.created_at.downcase == match.downcase }
  end

  def find_all_by_updated_at(match)
    entries.select { |entry| entry.updated_at.downcase == match.downcase }
  end

  def inspect
    "#<#{self.class} #{@entries.size} rows>"
  end
end
