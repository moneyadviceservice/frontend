RSpec.describe 'HomePage', type: :request do
  before do
    get '/en'
  end

  it 'successfully renders' do
    expect(response.status).to eq(200)
  end

  it 'displays home page heading' do
    expect(response.body).to include(
      'Free and impartial money advice, set up by government'
    )
  end

  it 'displays footer content' do
    expect(response.body).to include(
      'Give us a call for free and impartial money advice.'
    )
  end
end
