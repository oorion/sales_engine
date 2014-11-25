require_relative 'merchant'

class MerchantRepository
  attr_reader :entries

  def initialize(entries=[])
    @entries = entries
  end
end
