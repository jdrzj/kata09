class PricingRule
  attr_accessor :item, :regular_price, :special_price

  def initialize(item, regular_price, special_price)
    self.item = item
    self.regular_price = regular_price
    self.special_price = special_price
  end

  def count_price_for_items(items_count)
    total_price = 0
    loop do
      if !special_price.nil? && items_count >= special_price.quantity
        items_count -= special_price.quantity
        total_price += special_price.price
      else
        total_price += regular_price * items_count
        items_count = 0
      end
      break if items_count.zero?
    end
    total_price
  end
end
