RSpec.describe 'Article not found', type: :request do
  let(:id) { 'fake-article' }
  let(:status) { 404 }

  around do |example|
    Rails.application.config.consider_all_requests_local = false
    Rails.application.config.action_dispatch.show_exceptions = true
    stub_request(:get, %r{/en/articles/#{id}.json}).to_return(status: status)
    stub_request(:get, %r{/en/categories.json}).to_return(body: [].to_json)
    example.run
    Rails.application.config.consider_all_requests_local = true
    Rails.application.config.action_dispatch.show_exceptions = false
  end

  it 'returns a 404 response' do
    get("/en/articles/#{id}")

    expect(response.status).to eq(status)
  end
end
