# Kata09
## How to run tests?
`$ bundle install`
`$ rspec`
---
## Why my solution is appropriate?
By using two separate classes `Checkout`, `PricingRule` and `SpecialPrice`, and especially using method `count_price_for_items` in `PricingRule` makes it easier to add new rules. In that case we can create new rules classes that will inherit from this `PricingRule` class, and override `count_price_for_items` method. It will come without code changes in `Checkout` class.
By creating `PricingRule` we can validate items that will be added to checkout.
I created three separate classes; each is representing different entity. I use private method `pricing_rule_for` in `Checkout` class, because it's only used in class method. It makes code more readable.
