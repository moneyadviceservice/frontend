RSpec.describe PartnerToolsCookies do
  include Rack::Test::Methods

  def app
    described_class.new(->(env) { [200, env, 'Hello'] })
  end

  context "with a cookie being set" do
    before do
      header 'Set-Cookie', 'v=1'
      allow_any_instance_of(Rack::Request).to receive(:ssl?) { true }
    end

    it 'adds SameSite' do
      get '/'
      expect(last_response.headers['Set-Cookie']).to eq "v=1; SameSite=None"
    end
  end
end
