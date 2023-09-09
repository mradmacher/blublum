require "test_helper"

class User::FramesControllerTest < ActionDispatch::IntegrationTest
  test 'GET /frames is successful' do
    get '/user/frames'
    assert_response :success
  end

  test 'GET /frames returns empty collection when there are no frames' do
    get '/user/frames'
    assert JSON.parse(response.body).empty?
  end

  test 'GET /frames returns only active frames' do
    Frame.create(name: 'F1', status: Frame::ACTIVE, stock: 1)
    Frame.create(name: 'F2', status: Frame::INACTIVE, stock: 1)
    assert 2, Frame.count

    get '/user/frames'
    assert_response :success
    result = JSON.parse(response.body)
    assert 1, result.size
    assert result.any? { |frame| frame['status'] == Frame::ACTIVE }
    assert result.none? { |frame| frame['status'] == Frame::INACTIVE }
  end
end
