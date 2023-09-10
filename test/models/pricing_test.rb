require "test_helper"

class PricingTest < ActiveSupport::TestCase
  test 'validates curriences presence' do
    pricing = Pricing.new
    refute pricing.valid?
    assert pricing.errors.where(:usd, :blank).any?
    assert pricing.errors.where(:gbp, :blank).any?
    assert pricing.errors.where(:eur, :blank).any?
    assert pricing.errors.where(:jod, :blank).any?
    assert pricing.errors.where(:jpy, :blank).any?

    pricing.usd = 9.9
    pricing.gbp = 9.9
    pricing.eur = 9.9
    pricing.jod = 9.9
    pricing.jpy = 9.9
    pricing.valid?
    assert pricing.errors.where(:usd, :blank).none?
    assert pricing.errors.where(:gbp, :blank).none?
    assert pricing.errors.where(:eur, :blank).none?
    assert pricing.errors.where(:jod, :blank).none?
    assert pricing.errors.where(:jpy, :blank).none?
  end
end
