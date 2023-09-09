require "test_helper"

class FrameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'validates name presence' do
    frame = Frame.new
    refute frame.valid?
    assert frame.errors.where(:name, :blank).any?

    frame.name = 'xyz'
    frame.valid?
    assert frame.errors.where(:name, :blank).none?
  end


  test 'validates status presence' do
    frame = Frame.new
    refute frame.valid?
    assert frame.errors.where(:status, :blank).any?

    frame.status = Frame::ACTIVE
    frame.valid?
    assert frame.errors.where(:status, :blank).none?
  end

  test 'validates status inclusion' do
    frame = Frame.new(status: Frame::ACTIVE)
    frame.valid?
    assert frame.errors.where(:status, :inclusion).none?

    frame.status = Frame::INACTIVE
    frame.valid?
    assert frame.errors.where(:status, :inclusion).none?

    frame.status = 100
    frame.valid?
    refute frame.errors.where(:status, :inclusion).none?
  end

  test 'validates stock presence' do
    frame = Frame.new
    frame.valid?
    assert frame.errors.where(:stock, :blank).any?

    frame.stock = 1
    frame.valid?
    assert frame.errors.where(:stock, :blank).none?
  end
end
