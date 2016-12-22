RSpec.describe 'HomePage', type: :request do
  let(:category_repository)  { Core::Repository::Categories::Fake.new }
  let(:footer_repository)    { FakeFooterRepositoryDefinedInSpecHelper.new }
  let(:home_page_repository) { Core::Repository::HomePages::CMS.new }
  let(:clumps_repository)    { Core::Repository::Clumps::CMS.new }

  before do
    allow(Core::Registry::Repository).to receive(:[]).with(:home_page).and_return(home_page_repository)
    allow(Core::Registry::Repository).to receive(:[]).with(:footer).and_return(footer_repository)
    allow(Core::Registry::Repository).to receive(:[]).with(:category).and_return(category_repository)
    allow(Core::Registry::Repository).to receive(:[]).with(:clump).and_return(clumps_repository)

    get '/en'
  end

  it "successfully renders" do
    expect(response.status).to eq(200)
  end

  it 'displays footer content' do
    expect(response.body).to include('I am some content in a footer')
  end
end
