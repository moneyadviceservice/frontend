require 'spec_helper'

RSpec.describe 'Registration routing', features: [:registration], type: :request do
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
