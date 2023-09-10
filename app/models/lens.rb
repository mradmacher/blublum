class Lens < ApplicationRecord
  FASHION = 1
  SINGLE_VISION = 2
  VARIFOCAL = 3
  PRESCRIPTION_TYPES = [FASHION, SINGLE_VISION, VARIFOCAL].freeze

  CLASSIC = 1
  BLUE_LIGHT = 2
  TRANSITION = 3
  LENS_TYPES = [CLASSIC, BLUE_LIGHT, TRANSITION].freeze

  has_one :pricing, as: :priceable
  accepts_nested_attributes_for :pricing

  validates :name, presence: true
  validates :prescription_type, presence: true, inclusion: { in: PRESCRIPTION_TYPES }
  validates :lens_type, presence: true, inclusion: { in: LENS_TYPES }
  validates :stock, presence: true
  validates :pricing, presence: true
end
