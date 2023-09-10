require "test_helper"

class OrderTest < ActiveSupport::TestCase
  setup do
    @client = Client.create(currency: :gbp)
    @frame = Frame.create(
      name: 'F1',
      status: Frame::ACTIVE,
      stock: 1,
      pricing_attributes: { usd: 1, gbp: 2, eur: 3, jod: 4, jpy: 5 }
    )
    @lens = Lens.create(
      name: 'L1',
      prescription_type: Lens::FASHION,
      lens_type: Lens::CLASSIC,
      stock: 1,
      pricing_attributes: { usd: 1, gbp: 2, eur: 3, jod: 4, jpy: 5 }
    )
  end

  test 'validates client presence' do
    order = Order.new
    order.valid?
    assert order.errors.where(:client, :blank).any?

    order.client = @client
    order.valid?
    assert order.errors.where(:client, :blank).none?
  end

  test 'validates frame presence' do
    order = Order.new
    order.valid?
    assert order.errors.where(:frame, :blank).any?

    order.frame = @frame
    order.valid?
    assert order.errors.where(:frame, :blank).none?
  end

  test 'validates lens presence' do
    order = Order.new
    order.valid?
    assert order.errors.where(:lens, :blank).any?

    order.lens = @lens
    order.valid?
    assert order.errors.where(:lens, :blank).none?
  end

  test 'validates frames in stock' do
    order = Order.new

    @frame.update(stock: 0)
    order.frame = @frame
    order.valid?
    assert order.errors.where(:frame, :out_of_stock).any?

    @frame.update(stock: 1)
    order.frame = @frame
    order.valid?
    assert order.errors.where(:frame).none?
  end

  test 'validates lens in stock' do
    order = Order.new

    @lens.update(stock: 0)
    order.lens = @lens
    order.valid?
    assert order.errors.where(:lens, :out_of_stock).any?

    @lens.update(stock: 1)
    order.lens = @lens
    order.valid?
    assert order.errors.where(:lens).none?
  end

  test 'assigns client currency' do
    order = Order.new(client: @client)
    order.valid?
    assert_equal @client.currency, order.currency
  end

  test 'assigns frame + lens prices' do
    order = Order.new(frame: @frame, lens: @lens, client: @client)
    order.valid?
    assert_equal @client.currency, order.currency
    assert_equal @frame.pricing.gbp + @lens.pricing.gbp, order.price
  end

  test 'decreses frame and lens stock' do
    assert_equal 1, @frame.stock
    assert_equal 1, @lens.stock

    order = Order.create(frame: @frame, lens: @lens, client: @client)

    assert_equal 0, @frame.reload.stock
    assert_equal 0, @lens.reload.stock
  end
end
