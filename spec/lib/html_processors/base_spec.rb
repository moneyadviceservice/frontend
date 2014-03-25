require 'spec_helper'
require 'html_processor'

describe HTMLProcessor::Base, '#process' do
  let(:html) { '<p>a paragraph</p>' }
  let(:processor) { described_class.new(html) }

  subject(:processed_html) { processor.process }

  it { should eq(html) }
end
