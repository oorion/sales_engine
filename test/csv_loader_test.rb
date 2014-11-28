require_relative 'test_helper'
require_relative '../lib/csv_loader'

class CSVLoaderTest < Minitest::Test
  include CSVLoader

  def test_it_loads_a_file
    file_name = 'test/fixtures/merchants.csv'
    file = load_file(file_name)
    assert_instance_of CSV, file
  end
end
