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

  attr_accessor :merchant_repository,
                :invoice_repository,
                :item_repository,
                :invoice_item_repository,
                :customer_repository,
                :transaction_repository

  def initialize(directory = 'data')
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

  def find_merchant_from_merchant_repository(id)
    merchant_repository.find_by_id(id)
  end

  def find_invoice_from_invoice_repository(id)
    invoice_repository.find_by_id(id)
  end

  def find_customer_invoices_from_invoice_repository(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def find_merchant_invoices_from_invoice_repository(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_item_from_item_repository(id)
    item_repository.find_by_id(id)
  end

  def find_items_from_item_repository(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoice_invoice_items_from_invoice_item_repository(id)
    invoice_item_repository.find_all_by_invoice_id(id)
  end

  def find_item_invoice_items_from_invoice_item_repository(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_customer_from_customer_repository(id)
    customer_repository.find_by_id(id)
  end

  def find_transactions_from_transaction_repository(id)
    transaction_repository.find_all_by_invoice_id(id)
  end

  def find_items_by_way_of_invoice_item_repository(id)
    invoice_item_repository.find_and_convert_item_ids_to_items(id)
  end
end
