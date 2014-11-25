require_relative 'item'

class ItemRepository
  attr_reader :entries

  def initialize(entries = [])
    @entries = entries
  end

end
