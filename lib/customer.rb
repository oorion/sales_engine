class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, parent)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = parent
  end

  def invoices
    repository.find_invoices(id)
  end

  def transactions
    invoices.reduce([]) do |output, invoice|
      output + invoice.transactions
    end
  end

  def successful_transactions
    transactions.select do |transaction|
      transaction.result == "success"
    end
  end

  def favorite_merchant
    successful_merchants = successful_transactions.map do |transaction|
      transaction.invoice.merchant
    end
    grouped_merchants = successful_merchants.group_by { |merchant| merchant }
    grouped_merchants.max_by { |n| n[1].length }.first
  end
end
