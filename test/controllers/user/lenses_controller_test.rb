require "test_helper"

class User::LensesControllerTest < ActionDispatch::IntegrationTest
  test 'GET /lenses is successful' do
    get '/user/lenses'
    assert_response :success
  end

  test 'GET /lenses returns empty collection when there are no lenses' do
    get '/user/lenses'
    assert JSON.parse(response.body).empty?
  end

  test 'GET /lenses returns all lenses' do
    Lens.create(name: 'L1', prescription_type: Lens::FASHION, lens_type: Lens::CLASSIC, stock: 1)
    Lens.create(name: 'L2', prescription_type: Lens::VARIFOCAL, lens_type: Lens::BLUE_LIGHT, stock: 1)
    assert 2, Lens.count

    get '/user/lenses'
    assert_response :success
    result = JSON.parse(response.body)
    assert 2, result.size
    assert %w[L1, L2], result.map { |lens| lens['name'] }
  end
end
