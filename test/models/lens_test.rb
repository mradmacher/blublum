require "test_helper"

class LensTest < ActiveSupport::TestCase
  test 'validates name presence' do
    lens = Lens.new
    refute lens.valid?
    assert lens.errors.where(:name, :blank).any?

    lens.name = 'xyz'
    lens.valid?
    assert lens.errors.where(:name, :blank).none?
  end

  test 'validates prescription type inclusion' do
    lens = Lens.new(prescription_type: Lens::FASHION)
    lens.valid?
    assert lens.errors.where(:prescription_type, :inclusion).none?

    lens.prescription_type = Lens::SINGLE_VISION
    lens.valid?
    assert lens.errors.where(:prescription_type, :inclusion).none?

    lens.prescription_type = Lens::VARIFOCAL
    lens.valid?
    assert lens.errors.where(:prescription_type, :inclusion).none?

    lens.prescription_type = 100
    lens.valid?
    assert lens.errors.where(:prescription_type, :inclusion).any?
  end

  test 'validates lens type inclusion' do
    lens = Lens.new(lens_type: Lens::CLASSIC)
    lens.valid?
    assert lens.errors.where(:lens_type, :inclusion).none?

    lens.lens_type = Lens::BLUE_LIGHT
    lens.valid?
    assert lens.errors.where(:lens_type, :inclusion).none?

    lens.lens_type = Lens::TRANSITION
    lens.valid?
    assert lens.errors.where(:lens_type, :inclusion).none?

    lens.lens_type = 100
    lens.valid?
    assert lens.errors.where(:lens_type, :inclusion).any?
  end

  test 'validates stock presence' do
    lens = Lens.new
    lens.valid?
    assert lens.errors.where(:stock, :blank).any?

    lens.stock = 1
    lens.valid?
    assert lens.errors.where(:stock, :blank).none?
  end
end
