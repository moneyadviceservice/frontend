RSpec.describe PartnerToolsCookies do
  include Rack::Test::Methods

  def app
    described_class.new(->(env) { [200, env, 'Hello'] })
  end

  describe "with no `X-Syndicated-Tool' header" do
    before do
      header 'Set-Cookie', 'v=1'
      allow_any_instance_of(Rack::Request).to receive(:ssl?) { true }
    end

    it 'does not change any headers' do
      get '/'
      expect(last_response.headers['Set-Cookie']).to be_nil
    end
  end

  describe "with a `X-Syndicated-Tool' has been set to `true'" do
    before do
      header 'X-Syndicated-Tool', 'true'
      header 'Set-Cookie', 'v=1'
      allow_any_instance_of(Rack::Request).to receive(:ssl?) { true }
    end

    it 'set secure and SameSite to None' do
      get '/'
      expect(last_response.headers['Set-Cookie']).to eq "v=1; Secure; SameSite=None"
    end
  end
end
