require_relative 'customer'

class CustomerRepository
  attr_reader :entries

  def initialize(entries=[])
    @entries = entries
  end

  def find_by_first_name(first_name)
    @entries.find {|entries| entries.first_name == first_name}
    first_name
  end


end
