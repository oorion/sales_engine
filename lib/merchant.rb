class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, parent)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = parent
  end

  def invoices
    repository.find_invoices(id)
  end

  def items
    repository.find_items(id)
  end

  def revenue(date=nil)
    if date
      invoices_to_convert = successful_invoices.select do |invoice|
        Date.parse(invoice.updated_at) == date
      end
    else
      invoices_to_convert = successful_invoices
    end
    invoices_to_convert.reduce(0) do |sum, invoice|
      sum + invoice.invoice_items.reduce(0) do |sum, invoice_item|
        sum + (invoice_item.unit_price * invoice_item.quantity)
      end
    end
  end

  def successful_invoices
    invoices.select do |invoice|
      invoice.transactions.any? do |transaction|
        transaction.result == "success"
      end
    end
  end
end
