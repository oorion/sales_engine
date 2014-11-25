class Item
  attr_reader :id, :name, :description, :merchant_id, :created_at, :updated_at

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @merchant_id = data[:merchant_id]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

end
