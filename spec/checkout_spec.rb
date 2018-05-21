$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift('../lib')

require 'checkout'
require 'pricing_rule'
require 'special_price'

RSpec.describe Checkout do
  it 'add items when scans' do
    co = Checkout.new(rules)
    N = 10
    N.times do
      co.scan('A')
    end

    expect(co.items.count).to equal(N)
  end

  it 'sums the total price of items' do
    expect(price('')).to equal(0)
    expect(price('A')).to equal(50)
    expect(price('AB')).to equal(80)
    expect(price('CDBA')).to equal(115)

    expect(price('AA')).to equal(100)
    expect(price('AAA')).to equal(130)
    expect(price('AAAA')).to equal(180)
    expect(price('AAAAA')).to equal(230)
    expect(price('AAAAAA')).to equal(260)

    expect(price('AAAB')).to equal(160)
    expect(price('AAABB')).to equal(175)
    expect(price('AAABBD')).to equal(190)
    expect(price('DABABA')).to equal(190)
  end

  it 'sums the total price of items between scans' do
    co = Checkout.new(rules)
    expect(co.total).to equal(0)
    co.scan('A')
    expect(co.total).to equal(50)
    co.scan('B')
    expect(co.total).to equal(80)
    co.scan('A')
    expect(co.total).to equal(130)
    co.scan('A')
    expect(co.total).to equal(160)
    co.scan('B')
    expect(co.total).to equal(175)
  end

  def price(goods)
    co = Checkout.new(rules)
    goods.split(//).each { |item| co.scan(item) }
    co.total
  end

  def rules
    [
      PricingRule.new('A', 50, SpecialPrice.new(130, 3)),
      PricingRule.new('B', 30, SpecialPrice.new(45, 2)),
      PricingRule.new('C', 20, nil),
      PricingRule.new('D', 15, nil)
    ]
  end
end
