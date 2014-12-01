require 'bigdecimal'
require_relative 'merchant'

class MerchantRepository
  attr_reader :entries, :sales_engine

  def initialize(entries=[], parent)
    @entries = create_entries(entries)
    @sales_engine = parent
  end

  def create_entries(entries)
    entries.collect { |row| Merchant.new(row, self) }
  end

  def find_invoices(id)
    sales_engine.find_merchant_invoices_from_invoice_repository(id)
  end

  def find_items(id)
    sales_engine.find_items_from_item_repository(id)
  end

  def most_revenue(num)
    merchant_hash = {}
    entries.each do |merchant|
      total_revenue = merchant.invoices.map do |invoice|
        invoice.invoice_items.map do |invoice_item|
          (BigDecimal.new(invoice_item.unit_price) * 100) * (BigDecimal.new(invoice_item.quantity) * 100)
        end.reduce(:+)
      end.reduce(:+)
      merchant_hash[total_revenue] = merchant
    end
    merchant_hash.keys.sort.reverse[0..num-1].map do |revenue|
      merchant_hash[revenue]
    end
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
    entries.find { |entry| entry.name.downcase == match.downcase }
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

  def find_all_by_name(match)
    entries.select { |entry| entry.name.downcase == match.downcase }
  end

  def find_all_by_created_at(match)
    entries.select { |entry| entry.created_at.downcase == match.downcase }
  end

  def find_all_by_updated_at(match)
    entries.select { |entry| entry.updated_at.downcase == match.downcase }
  end
end
