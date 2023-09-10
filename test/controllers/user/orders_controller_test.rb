require "test_helper"

class User::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = Client.create!(currency: :gbp)
    @frame = Frame.create!(
      name: 'F1',
      status: Frame::ACTIVE,
      stock: 10,
      pricing_attributes: { usd: 1, gbp: 2, eur: 3, jod: 4, jpy: 5 }
    )
    @lens = Lens.create!(
      name: 'L1',
      prescription_type: Lens::FASHION,
      lens_type: Lens::CLASSIC,
      stock: 100,
      pricing_attributes: { usd: 10, gbp: 20, eur: 30, jod: 40, jpy: 50 }
    )
  end

  test 'POST /orders creates a new order' do
    post '/user/orders', params: {
      order: {
        client_id: @client.id,
        frame_id: @frame.id,
        lens_id: @lens.id,
      }
    }
    assert_response :success
    result = JSON.parse(response.body)

    new_order = Order.where(id: result['id']).first
    refute_nil new_order
    assert_equal @client, new_order.client
    assert_equal @frame, new_order.frame
    assert_equal @lens, new_order.lens
    assert_equal 'gbp', new_order.currency
    assert_equal @frame.pricing.gbp + @lens.pricing.gbp, new_order.price
  end

  test 'POST /orders does not create an order when frames are out of stock' do
    @frame.update(stock: 0)

    post '/user/orders', params: {
      order: {
        client_id: @client.id,
        frame_id: @frame.id,
        lens_id: @lens.id,
      }
    }
    assert_response :unprocessable_entity
    result = JSON.parse(response.body)
    assert_equal 'Frame is out of stock', result['errors'].first
  end

  test 'POST /orders does not create an order when lenses are out of stock' do
    @lens.update(stock: 0)

    post '/user/orders', params: {
      order: {
        client_id: @client.id,
        frame_id: @frame.id,
        lens_id: @lens.id,
      }
    }
    assert_response :unprocessable_entity
    result = JSON.parse(response.body)
    assert_equal 'Lens is out of stock', result['errors'].first
  end

  test 'POST /orders decreses frame and lens stock' do
    assert_equal 10, @frame.stock
    assert_equal 100, @lens.stock

    post '/user/orders', params: {
      order: {
        client_id: @client.id,
        frame_id: @frame.id,
        lens_id: @lens.id,
      }
    }
    assert_response :success
    assert_equal 9, @frame.reload.stock
    assert_equal 99, @lens.reload.stock
  end
end
