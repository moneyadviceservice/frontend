require 'html_processor/base'

RSpec.describe HTMLProcessor::Base, '#process' do
  subject { described_class.new('<p>a paragraph</p>').process }

  it { is_expected.to eq('<p>a paragraph</p>') }
end
