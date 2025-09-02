# 💵💰💳 Amenitiz Cash Register

[![Ruby](https://img.shields.io/badge/language-Ruby%203.2.3-red.svg)](https://ruby-lang.org/)
[![Rails](https://img.shields.io/badge/framework-Rails%208-red.svg)](https://rubyonrails.org/)
[![RSpec](https://img.shields.io/badge/testing-RSpec-green.svg)](https://rspec.info/)

Technical evaluation solution for building a cash register system with flexible pricing rules.

⚙️ Tech Stack

- Ruby 3.2.3
- Rails 8.0
- MySQL
- HAML views
- Stimulus controller (JavaScript)
- Custom CSS
- RSpec testing

🛠 Setup

```bash
git clone [repo-url]
cd cash-register
bundle install
rails db:create db:migrate
rails db:fixtures:load FIXTURES=products,offers
rails server
```
✅ Problem Solved

Built a cash register application that handles:

1.Product scanning and cart management

2.Multiple discount types (BOGOF, bulk discount, fractional discount)

3.Flexible pricing rules that can change easily

📦 Products

GR1: Green Tea (€3.11)

SR1: Strawberries (€5.00)

CF1: Coffee (€11.23)

💸 Special Offers Implemented

🆓 BOGOF (Buy One Get One Free) - Green Tea

Rule: Buy 1 Green Tea, get 1 free

Implementation: BogofOffer class

🎟️ Bulk Discount - Strawberries

Rule: 3+ strawberries → €4.50 each (instead of €5.00)

Implementation: BulkDiscountOffer class

🔢 Fractional Discount - Coffee

Rule: 3+ coffees → 2/3 of original price (33% off)

Implementation: FractionalDiscountOffer class

Architecture Decisions
Single Table Inheritance (STI)

Used STI pattern for offers to allow easy extension of discount types:
Offer (base)
├── BogofOffer
├── BulkDiscountOffer  
└── FractionalDiscountOffer

💡Benefits:

*Easy to add new offer types

*Each offer implements its own apply() logic

*Database stays simple with one offers table

🛒 Checkout Class

Handles cart logic and total calculation. Groups items by product and applies relevant offers.

🕵️‍♂️ Session-based Cart

Cart state stored in Rails session for simplicity. No user accounts needed.

📊 Test Coverage

All required test cases implemented:
- GR1,GR1 → €3.11
- SR1,SR1,GR1,SR1 → €16.61
- GR1,CF1,SR1,CF1,CF1 → €30.57

Additional tests included:
- Individual product limits (1 item, 4 coffees, etc.)
- Comprehensive unit tests for each discount type
- Controller tests for cart management (`scan`, `clear`)
  
```bash
bundle exec rspec

