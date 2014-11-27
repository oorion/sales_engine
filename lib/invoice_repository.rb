require_relative 'invoice'

class InvoiceRepository
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

  def find_by_customer_id(match)
    entries.find { |entry| entry.customer_id == match }
  end

  def find_by_merchant_id(match)
    entries.find { |entry| entry.merchant_id == match }
  end

  def find_by_status(match)
    entries.find { |entry| entry.status.downcase == match.downcase }
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

  def find_all_by_customer_id(match)
    entries.select { |entry| entry.customer_id == match }
  end

  def find_all_by_merchant_id(match)
    entries.select { |entry| entry.merchant_id == match }
  end

  def find_all_by_status(match)
    entries.select { |entry| entry.status.downcase == match.downcase }
  end

  def find_all_by_created_at(match)
    entries.select { |entry| entry.created_at.downcase == match.downcase }
  end

  def find_all_by_updated_at(match)
    entries.select { |entry| entry.updated_at.downcase == match.downcase }
  end

end
