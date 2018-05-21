class Checkout
  attr_accessor :pricing_rules, :items

  def initialize(pricing_rules)
    self.pricing_rules = pricing_rules
    self.items = []
  end

  def scan(item)
    items << item
  end

  def total
    total_price = 0
    items.uniq.each do |item_name|
      items_count = items.count(item_name)
      rule = pricing_rule_for(item_name)
      total_price += rule.count_price_for_items(items_count)
    end
    total_price
  end

  private

  def pricing_rule_for(item_name)
    pricing_rules.each do |rule|
      return rule if rule.item == item_name
    end
  end
end
