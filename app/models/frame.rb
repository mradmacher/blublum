class Frame < ApplicationRecord
  ACTIVE = 1
  INACTIVE = 0
  STATUSES = [ACTIVE, INACTIVE]

  has_one :pricing, as: :priceable
  accepts_nested_attributes_for :pricing

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :stock, presence: true
  validates :pricing, presence: true, if: -> { status == ACTIVE }
end
