$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift('../lib')

require 'checkout'
require 'pricing_rule'
require 'special_price'

RSpec.describe PricingRule do
  it 'sums total price for items' do
    pricing_rules = [
      PricingRule.new('X', 50, SpecialPrice.new(130, 3)),
      PricingRule.new('Y', 40, nil)
    ]

    expect(pricing_rules[0].count_price_for_items(1)).to equal(50)
    expect(pricing_rules[0].count_price_for_items(2)).to equal(100)
    expect(pricing_rules[0].count_price_for_items(3)).to equal(130)
    expect(pricing_rules[0].count_price_for_items(4)).to equal(180)

    expect(pricing_rules[1].count_price_for_items(1)).to equal(40)
    expect(pricing_rules[1].count_price_for_items(2)).to equal(80)
    expect(pricing_rules[1].count_price_for_items(3)).to equal(120)
    expect(pricing_rules[1].count_price_for_items(4)).to equal(160)
  end
end
