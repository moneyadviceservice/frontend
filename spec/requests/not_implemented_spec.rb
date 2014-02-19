require_relative '../spec_helper'

describe 'Request we have no implementation for' do
  it 'returns a 501 response' do
    get('/unsupported')

    expect(response.status).to eq(501)
  end
end
