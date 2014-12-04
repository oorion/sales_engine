require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price]) / 100
    @merchant_id = data[:merchant_id].to_i
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = parent
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def best_day
    invoice_items.flat_map do |ii|
      [Date.parse(ii.invoice.created_at)] * ii.quantity
    end.group_by do |date|
      date
    end.map do |key, value|
      [key, value.length]
    end.max_by do |item|
      item[1]
    end[0]
  end
end
