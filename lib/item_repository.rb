require_relative 'item'

class ItemRepository
  attr_reader :entries, :sales_engine

  def initialize(entries = [], parent)
    @entries = create_entries(entries)
    @sales_engine = parent
  end

  def create_entries(entries)
    entries.collect { |row| Item.new(row, self) }
  end

  def find_invoice_items(id)
    sales_engine.find_item_invoice_items_from_invoice_item_repository(id)
  end

  def find_merchant(id)
    sales_engine.find_merchant_from_merchant_repository(id)
  end

  def most_revenue(num)
    entries.each_with_object({}) do |item, hash|
      item_revenue = item.invoice_items.reduce(0) do |sum, ii|
        sum + ii.unit_price * ii.quantity
      end
      hash[item] = item_revenue
    end.sort_by { |key, val| val }.reverse.map { |n| n[0] }[0..num-1]
  end

  def most_items(num)
    entries.each_with_object({}) do |item, hash|
      successful_invoice_items = item.invoice_items.select { |ii| ii.successful? }
      total_quantity = successful_invoice_items.reduce(0) {|sum, n| sum + n.quantity}
      hash[item] = total_quantity
    end.sort_by { |key, val| val }.reverse.map { |n| n[0] }[0..num-1]
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

  def find_by_description(match)
    entries.find { |entry| entry.description.downcase == match.downcase }
  end

  def find_by_unit_price(match)
    entries.find { |entry| entry.unit_price == match }
  end

  def find_by_merchant_id(match)
    entries.find { |entry| entry.merchant_id == match }
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

  def find_all_by_description(match)
    entries.select { |entry| entry.description.downcase == match.downcase }
  end

  def find_all_by_unit_price(match)
    entries.select { |entry| entry.unit_price == match }
  end

  def find_all_by_merchant_id(match)
    entries.select { |entry| entry.merchant_id == match }
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
