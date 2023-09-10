class Order < ApplicationRecord
  belongs_to :client
  belongs_to :frame
  belongs_to :lens

  validates :client, presence: true
  validates :frame, presence: true
  validate :frame_in_stock, if: -> { frame }
  validate :lens_in_stock, if: -> { lens }
  validates :lens, presence: true

  #validates :currency, presence: true, inclusion: { in: Client::CURRENCIES }
  #validates :price, presence: true

  after_validation :assign_price
  before_save :decrement_stock

  private

  def frame_in_stock
    if frame.stock < 1
      errors.add(:frame, :out_of_stock)
    end
  end

  def lens_in_stock
    if lens.stock < 1
      errors.add(:lens, :out_of_stock)
    end
  end

  def assign_price
    if client_id_changed? && client
      self.currency = client.currency
    end

    if frame_id_changed? && lens_id_changed? && frame && lens
      self.price = frame.pricing.send(client.currency) + lens.pricing.send(client.currency)
    end
  end

  def decrement_stock
    frame.decrement!(:stock) if frame_id_changed?
    lens.decrement!(:stock) if lens_id_changed?
  end
end
