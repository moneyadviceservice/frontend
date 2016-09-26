RSpec.describe Core::ConnectionFactory::Http, '.build' do
  subject(:factory) { described_class.build('http://example.com') }

  it "manufactures a `Core::Connection::Http'" do
    expect(factory).to be_a(Core::Connection::Http)
  end

  it 'has a default timeout of 5 seconds' do
    expect(factory.options[:timeout]).to eq(5)
  end

  it 'has a default open timeout of 5 seconds' do
    expect(factory.options[:open_timeout]).to eq(5)
  end

  it 'defaults to encoding JSON requests' do
    expect(factory.builder.handlers).to include(FaradayMiddleware::EncodeJson)
  end

  it 'defaults to retrying failed requests' do
    expect(factory.builder.handlers).to include(Faraday::Request::Retry)
  end

  it "defaults to including an `X-Request-Id' request header" do
    expect(factory.builder.handlers).to include(Faraday::Request::RequestId)
  end

  it 'defaults to parsing JSON responses' do
    expect(factory.builder.handlers).to include(FaradayMiddleware::ParseJson)
  end

  it 'defaults to raising an error on failed responses' do
    expect(factory.builder.handlers).to include(Faraday::Response::RaiseError)
  end

  it 'defaults to parsing link headers' do
    expect(factory.builder.handlers).to include(Faraday::Response::LinkHeader)
  end

  it 'includes instrumentation' do
    expect(factory.builder.handlers).to include(FaradayMiddleware::Instrumentation)
  end

  it 'uses Faraday::Adapter::NetHttp by default' do
    expect(factory.builder.handlers).to include(Faraday::Adapter::NetHttp)
  end
end
