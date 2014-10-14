require 'spec_helper'

RSpec.describe 'Registration routing', type: :request do
  around :each do |example|
    Feature.run_with_activated(:registration) do
      Rails.application.reload_routes!

      example.run
    end

    Rails.application.reload_routes!
  end

  it '501 on user updating account details' do
    get('/en/users/edit')
    expect(response.status).to eq(501)
  end

  it '501 on user updating account details' do
    put('/en/users')
    expect(response.status).to eq(501)
  end

  it '501 on user updating account details' do
    patch('/en/users')
    expect(response.status).to eq(501)
  end
end
