require 'spec_helper'

class Dummy < ActiveResource::Base
  self.site = 'http://something'
end

class OtherDummy < ActiveResource::Base
  self.site = 'http://somethingelse'
end

describe 'ActiveResource::Base' do
  before(:each) { Thread.current['request-id'] = nil }
  after(:each) { FakeWeb.last_request = nil }

  it 'should add a request Id header only if Thread.Current has it' do
    FakeWeb.register_uri(:get, 'http://somethingelse/other_dummies/id.json', status: 200, body: '{}')
    OtherDummy.find('id')
    request = FakeWeb.last_request
    expect(request['X-Request-Id']).to eq(nil)
  end

  it 'should add a request Id header' do
    Thread.current['request-id'] = 'current-request-id'
    FakeWeb.register_uri(:get, 'http://something/dummies/id.json', status: 200, body: '{}')
    Dummy.find('id')
    request = FakeWeb.last_request
    expect(request['X-Request-Id']).to eq('current-request-id')
  end

end