require "test_helper"

class ClientTest < ActiveSupport::TestCase
  test 'validates currency presence' do
    client = Client.new
    client.valid?
    assert client.errors.where(:currency, :blank).any?

    client.currency = :usd
    client.valid?
    assert client.errors.where(:currency, :blank).none?
  end

  test 'validates currency inclusion' do
    client = Client.new

    Client::CURRENCIES.each do |currency|
      client.currency = currency
      client.valid?
      assert client.errors.where(:currency, :blank).none?
    end

    client.currency = :pln
    client.valid?
    assert client.errors.where(:currency, :inclusion).any?
  end
end
