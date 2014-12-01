require_relative 'invoice'

class InvoiceRepository
  attr_reader :entries, :sales_engine

  def initialize(entries = [], parent)
    @entries = create_entries(entries)
    @sales_engine = parent
  end

  def create_entries(entries)
    entries.collect { |row| Invoice.new(row, self) }
  end

  def find_transactions(id)
    sales_engine.find_transactions_from_transaction_repository(id)
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_invoice_items_from_invoice_item_repository(id)
  end

  def find_items(id)
    sales_engine.find_items_by_way_of_invoice_item_repository(id)
  end

  def find_customer(id)
    sales_engine.find_customer_from_customer_repository(id)
  end

  def find_merchant(id)
    sales_engine.find_merchant_from_merchant_repository(id)
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
