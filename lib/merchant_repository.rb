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
    entries.sort_by do |merchant|
      merchant.revenue
    end.reverse[0..num-1]
  end

  def revenue(date)
    entries.reduce(0) { |sum, merchant| sum + merchant.revenue(date) }
  end

  def most_items(num)
    sorted_merchants_and_items_sold = merchants_and_items_sold.sort_by do |n|
      n[1]
    end.reverse
    sorted_merchants_and_items_sold.map do |n|
      n[0]
    end[0..num-1]
  end

  def merchants_and_items_sold
    entries.map do |merchant|
      [ merchant, merchant.number_of_items_sold ]
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

  def inspect
    "#<#{self.class} #{@entries.size} rows>"
  end
end
