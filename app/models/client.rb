class Client < ApplicationRecord
  CURRENCIES = %w[usd gbp eur jod jpy].freeze

  validates :currency, presence: true, inclusion: { in: CURRENCIES }
end
