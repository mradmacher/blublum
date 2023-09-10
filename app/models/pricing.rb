class Pricing < ApplicationRecord
  belongs_to :priceable, polymorphic: true
  validates :usd, presence: true
  validates :gbp, presence: true
  validates :eur, presence: true
  validates :jod, presence: true
  validates :jpy, presence: true
end
