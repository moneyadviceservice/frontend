RSpec.describe 'HomePage', type: :request do
  let(:category_repository)  { Core::Repository::Categories::Fake.new }
  let(:footer_repository)    { Core::Repository::Footer::Static.new }
  let(:home_page_repository) { Core::Repository::HomePages::Static.new }

  before do
    allow(Core::Registry::Repository).to receive(:[]).with(:home_page).and_return(home_page_repository)
    allow(Core::Registry::Repository).to receive(:[]).with(:footer).and_return(footer_repository)
    allow(Core::Registry::Repository).to receive(:[]).with(:category).and_return(category_repository)
  end

  it "successfully renders" do
    get '/en'
    expect(response.status).to eq(200)
  end

  it 'displays footer content' do
    get '/en'
    expect(response.body).to include('Give us a call for free and impartial money advice.')
  end

  it 'correctly displays content in welsh too' do
    get '/cy'
    expect(response.body).to include('Ffoniwch ni am gyngor ariannol am ddim a diduedd.')
  end
end
