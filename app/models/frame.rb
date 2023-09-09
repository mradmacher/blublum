class Frame < ApplicationRecord
  ACTIVE = 1
  INACTIVE = 0

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: [ACTIVE, INACTIVE] }
  validates :stock, presence: true
end
