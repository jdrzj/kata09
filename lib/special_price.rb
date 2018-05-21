class SpecialPrice
  attr_accessor :price, :quantity

  def initialize(price, quantity)
    self.price = price
    self.quantity = quantity
  end
end
