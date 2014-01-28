require 'spec_helper'

describe CaptureRequestIdMiddleware do
  before { @current_request_id = Thread.current['request-id'] }
  after { Thread.current['request-id'] = @current_request_id }

  it 'records the request id in the current thread context' do

    Thread.current['request-id'] = ''
    captureRequest = CaptureRequestIdMiddleware.new(double(:call => ''))
    env = {'action_dispatch.request_id' => 'auto-genereated-request-id'}
    captureRequest.call(env)
    expect(Thread.current['request-id']).to eq('auto-genereated-request-id')

  end

end
