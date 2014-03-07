require 'spec_helper'
require 'route_probe'

describe RouteProbe do
  include Rack::Test::Methods

  let(:error) { ActionController::RoutingError.new(double) }

  def app
    described_class.new(->(env) { [200, env, 'Hello World'] })
  end

  context "with no `X-Route-Probe' header" do
    context 'when the route exists' do
      before do
        expect(Rails.application.routes).to receive(:recognize_path) { double }

        get '/'
      end

      it 'calls the app' do
        expect(last_response).to be_ok
        expect(last_response.body).to eq('Hello World')
      end
    end

    context 'when the route does not exists' do
      before do
        expect(Rails.application.routes).to receive(:recognize_path).and_raise(error)

        get '/'
      end

      it 'returns 501 NOT IMPLEMENTED' do
        expect(last_response.status).to eq(501)
      end
    end
  end

  context "with a `X-Route-Probe' has been set to `true'" do
    before { header 'X-Route-Probe', 'true' }

    context 'when the route exists' do
      before do
        expect(Rails.application.routes).to receive(:recognize_path) { double }

        get '/'
      end

      it 'returns no content' do
        expect(last_response.length).to eq(0)
        expect(last_response.body).to be_empty
      end
    end

    context 'when the route does not exists' do
      before do
        expect(Rails.application.routes).to receive(:recognize_path).and_raise(error)

        get '/'
      end

      it 'returns 501 NOT IMPLEMENTED' do
        expect(last_response.status).to eq(501)
      end
    end
  end
end
