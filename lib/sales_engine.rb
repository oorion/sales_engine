require 'csv'
require_relative 'csv_loader'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'item_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'transaction'
require_relative 'transaction_repository'

class SalesEngine
  include CSVLoader

  attr_reader :customer_repository

  def initialize(directory = 'data/')
    merchant_entries = load_file(directory + 'merchants.csv')
    @merchant_repository = MerchantRepository.new(merchant_entries, self)

    invoice_entries = load_file(directory + 'invoices.csv')
    @invoice_repository = InvoiceRepository.new(invoice_entries, self)

    item_entries = load_file(directory + 'items.csv')
    @item_repository = ItemRepository.new(item_entries, self)

    invoice_item_entries = load_file(directory + 'invoice_items.csv')
    @invoice_item_repository = InvoiceItemRepository.new(invoice_item_entries, self)

    customer_entries = load_file(directory + 'customers.csv')
    @customer_repository = CustomerRepository.new(customer_entries, self)

    transaction_entries = load_file(directory + 'transactions.csv')
    @transaction_repository = TransactionRepository.new(transaction_entries, self)
  end
end
