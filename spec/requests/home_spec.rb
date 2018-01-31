RSpec.describe 'HomePage', type: :request do
  let(:footer_repository)    { FakeFooterRepositoryDefinedInSpecHelper.new }
  let(:clumps_repository)    { Core::Repository::Clumps::CMS.new }

  before do
    allow(Core::Registry::Repository).to receive(:[]).with(:footer).and_return(footer_repository)
    allow(Core::Registry::Repository).to receive(:[]).with(:clump).and_return(clumps_repository)

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
    expect(response.body).to include('I am some content in a footer')
  end
end
