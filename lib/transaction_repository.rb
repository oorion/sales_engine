require_relative 'transaction'

class TransactionRepository
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

  def find_by_invoice_id(match)
    entries.find { |entry| entry.invoice_id == match }
  end

  def find_by_credit_card_number(match)
    entries.find { |entry| entry.credit_card_number == match }
  end

  def find_by_credit_card_expiration_date(match)
    entries.find { |entry| entry.credit_card_expiration_date == match }
  end

  def find_by_result(match)
    entries.find { |entry| entry.result.downcase == match.downcase }
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

  def find_all_by_credit_card_number(match)
    entries.select { |entry| entry.credit_card_number == match }
  end

  def find_all_by_credit_card_expiration_date(match)
    entries.select { |entry| entry.credit_card_expiration_date == match }
  end

  def find_all_by_result(match)
    entries.select { |entry| entry.result.downcase == match.downcase }
  end

  def find_all_by_created_at(match)
    entries.select { |entry| entry.created_at.downcase == match.downcase }
  end

  def find_all_by_updated_at(match)
    entries.select { |entry| entry.updated_at.downcase == match.downcase }
  end
end
