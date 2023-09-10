require "test_helper"

class Admin::FramesControllerTest < ActionDispatch::IntegrationTest
  test 'GET /frames is successful' do
    get '/admin/frames'
    assert_response :success
  end

  test 'GET /frames returns empty collection when there are no frames' do
    get '/admin/frames'
    assert JSON.parse(response.body).empty?
  end

  test 'GET /frames returns active and inactive frames' do
    Frame.create(name: 'F1', status: Frame::ACTIVE, stock: 1)
    Frame.create(name: 'F2', status: Frame::INACTIVE, stock: 1)

    get '/admin/frames'
    assert_response :success
    result = JSON.parse(response.body)
    assert result.any? { |frame| frame['name'] == 'F1' && frame['status'] == Frame::ACTIVE }
    assert result.any? { |frame| frame['name'] == 'F2' && frame['status'] == Frame::INACTIVE }
  end

  test 'POST /frames creates a new frame' do
    post '/admin/frames', params: {
      frame: {
        name: 'A brand new frame',
        description: 'This is going to be a success',
        stock: 0,
        status: Frame::INACTIVE
      }
    }
    assert_response :success
    result = JSON.parse(response.body)

    new_frame = Frame.where(id: result['id']).first
    refute_nil new_frame
    assert_equal 'A brand new frame', new_frame.name
    assert_equal 'This is going to be a success', new_frame.description
    assert_equal 0, new_frame.stock
    assert_equal Frame::INACTIVE, new_frame.status
  end

  test 'POST /frames returns errors for invalid data' do
    post '/admin/frames', params: {
      frame: {
        status: 1000
      }
    }
    assert_response :unprocessable_entity
    result = JSON.parse(response.body)
    refute_predicate result, :empty?
    expected_errors = ["Name can't be blank", "Status is not included in the list", "Stock can't be blank"]
    assert_equal expected_errors, result['errors']

    assert 0, Frame.count
  end
end
