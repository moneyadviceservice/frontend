require 'spec_helper'

describe CaptureRequestIdMiddleware do
  subject { described_class.new(double(call: nil)) }

  describe '#call' do
    let(:request_id) { double }
    before { subject.call('action_dispatch.request_id' => nil) }

    it 'stores the request id in the current thread' do
      expect { subject.call('action_dispatch.request_id' => request_id) }.
        to change { Thread.current['request-id'] }.from(nil).to(request_id)
    end
  end
end