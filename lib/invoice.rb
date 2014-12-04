class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository,
              :customer,
              :merchant,
              :items

  # dependency inversion
  def initialize(data, parent)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = parent
    @customer    = data[:customer]
    @merchant    = data[:merchant]
    @items       = data[:items]
  end

  def transactions
    repository.find_transactions(id)
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def items
    @items ||= repository.find_items(id)
  end

  def customer
    @customer ||= repository.find_customer(customer_id)
  end

  def merchant
    @merchant ||= repository.find_merchant(merchant_id)
  end

  def successful?
    transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def charge(credit_data)
    repository.sales_engine.transaction_repository.create_entry({
      id: repository.sales_engine.transaction_repository.entries.last.id + 1,
      invoice_id: id,
      credit_card_number: credit_data[:credit_card_number],
      credit_card_expiration_date: credit_data[:credit_card_expiration],
      result: credit_data[:result],
      created_at: Time.now.utc,
      updated_at: Time.now.utc
      })
  end
end
