require 'html_processor/base'

describe HTMLProcessor::Base, '#process' do
  subject { described_class.new('<p>a paragraph</p>').process }

  it { should eq('<p>a paragraph</p>') }
end
