require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :entries, :sales_engine

  def initialize(entries = [], parent)
    @entries = create_entries(entries)
    @sales_engine = parent
  end

  def create_entries(entries)
    entries.collect { |row| InvoiceItem.new(row, self) }
  end

  def find_invoice(id)
    sales_engine.find_invoice_from_invoice_repository(id)
  end

  def find_item(id)
    sales_engine.find_item_from_item_repository(id)
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

  def find_and_convert_item_ids_to_items(id)
    invoice_items_found = find_all_by_invoice_id(id)
    convert_invoice_item_to_item(invoice_items_found).compact!.uniq
  end

  def convert_invoice_item_to_item(invoice_items)
    invoice_items.map do |invoice_item|
      sales_engine.find_item_from_item_repository(invoice_item.item_id)
    end
  end

  def inspect
    "#<#{self.class} #{@entries.size} rows>"
  end
end
