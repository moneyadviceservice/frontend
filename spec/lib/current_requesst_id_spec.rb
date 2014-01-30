require 'spec_helper'
require 'current_request_id'

describe CurrentRequestId do
  let(:request_id_key) { 'request-id' }
  let(:request_id) { "123" }

  after { Thread.current[request_id_key] = nil }

  describe '.set' do
    it "stores a value in Thread.current['request_id']" do
      CurrentRequestId.set(request_id)
      expect(Thread.current[request_id_key]).to be(request_id)
    end
  end

  describe '.get' do
    before { CurrentRequestId.set(request_id) }

    it "retrieves the value of Thread.current['request_id']" do
      expect(CurrentRequestId.get).to be(Thread.current[request_id_key])
    end
  end

  describe '.clear' do
    before { CurrentRequestId.set(request_id) }

    it "cleans the value of Thread.current['request_id']" do
      CurrentRequestId.clear!
      expect(Thread.current[request_id_key]).to be_nil
    end
  end
end