require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new
  end

  def test_case_name
    assert_instance_of CustomerRepository, sales_engine.customer_repository
    assert_instance_of Customer, sales_engine.customer_repository.entries[0]
  end
end
