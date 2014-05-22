require 'current_request_id'

RSpec.describe CaptureRequestId do
  subject(:capture_request_middleware) do
    described_class.new(double(call: nil))
  end

  let(:request_id_key) { 'request_id' }

  after(:context) { CurrentRequestId.clear! }

  describe '#call' do
    let(:request_id) { double }
    before { CurrentRequestId.clear! }

    it 'stores the request_id in CurrentRequestId' do
      capture_request_middleware.call('action_dispatch.request_id' => request_id)

      expect(CurrentRequestId.get).to eq(request_id)
    end
  end
end
