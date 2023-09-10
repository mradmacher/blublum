require "test_helper"

class Admin::LensesControllerTest < ActionDispatch::IntegrationTest
  test 'GET /lenses is successful' do
    get '/admin/lenses'
    assert_response :success
  end

  test 'GET /lenses returns empty collection when there are no lenses' do
    get '/admin/lenses'
    assert JSON.parse(response.body).empty?
  end

  test 'GET /lenses returns all lenses' do
    Lens.create(
      name: 'L1',
      prescription_type: Lens::FASHION,
      lens_type: Lens::CLASSIC,
      stock: 1,
      pricing_attributes: { usd: 1, gbp: 2, eur: 3, jod: 4, jpy: 5 }
    )
    Lens.create(
      name: 'L2',
      prescription_type: Lens::VARIFOCAL,
      lens_type: Lens::BLUE_LIGHT,
      stock: 1,
      pricing_attributes: { usd: 1, gbp: 2, eur: 3, jod: 4, jpy: 5 }
    )

    get '/admin/lenses'
    assert_response :success
    result = JSON.parse(response.body)
    assert 2, result.size
    assert result.any? { |lens| lens['name'] == 'L1' }
    assert result.any? { |lens| lens['name'] == 'L2' }
  end

  test 'POST /lenses creates a new lens' do
    post '/admin/lenses', params: {
      lens: {
        name: 'I am a lens',
        description: 'This is a good lens',
        stock: 1,
        prescription_type: Lens::SINGLE_VISION,
        lens_type: Lens::CLASSIC,
        pricing_attributes: {
          usd: 1,
          gbp: 2,
          eur: 3,
          jod: 4,
          jpy: 5,
        },
      }
    }
    assert_response :success
    result = JSON.parse(response.body)

    new_lens = Lens.where(id: result['id']).first
    refute_nil new_lens
    assert_equal 'I am a lens', new_lens.name
    assert_equal 'This is a good lens', new_lens.description
    assert_equal 1, new_lens.stock
    assert_equal Lens::SINGLE_VISION, new_lens.prescription_type
    assert_equal Lens::CLASSIC, new_lens.lens_type

    refute_nil new_lens.pricing
    assert_equal 1.0, new_lens.pricing.usd
    assert_equal 2.0, new_lens.pricing.gbp
    assert_equal 3.0, new_lens.pricing.eur
    assert_equal 4.0, new_lens.pricing.jod
    assert_equal 5.0, new_lens.pricing.jpy
  end

  test 'POST /lenses returns errors for invalid data' do
    post '/admin/lenses', params: {
      lens: {
        prescription_type: 123,
        lens_type: 321,
      }
    }
    assert_response :unprocessable_entity
    result = JSON.parse(response.body)
    refute_predicate result, :empty?
    expected_errors = [
      "Name can't be blank",
      "Prescription type is not included in the list",
      "Lens type is not included in the list",
      "Stock can't be blank",
      "Pricing can't be blank",
    ]
    assert_equal expected_errors, result['errors']

    assert 0, Lens.count
  end
end
