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

  def initialize
    customer_entries = load_file('test/fixtures/customer_fixture.csv')
    @customer_repository = CustomerRepository.new(customer_entries, self)
  end

  # def get_file_path(file_name)
  #   expanded_path = File.expand_path('../test/fixtures', __dir__)
  #   File.join(expanded_path, file_name)
  # end
  #
  # def load_file(file_name)
  #   file_path = get_file_path(file_name)
  #   CSV.open(file_path, headers: true, header_converters: :symbol)
  # end
end
