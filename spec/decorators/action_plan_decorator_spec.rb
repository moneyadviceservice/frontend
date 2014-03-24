require 'spec_helper'
require 'core/entities/action_plan'

describe ActionPlanDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(action_plan) }

  let(:action_plan) { double(Core::ActionPlan, id: 'bob') }

  it { should respond_to(:alternate_options) }
  it { should respond_to(:canonical_url) }
  it { should respond_to(:content) }
  it { should respond_to(:description) }
  it { should respond_to(:title) }

  describe '#alternate_options' do
    context 'when there are no alternates' do
      before { allow(action_plan).to receive(:alternates) { [] } }

      it 'returns an empty hash' do
        expect(decorator.alternate_options).to be_a(Hash)
        expect(subject.alternate_options).to be_empty
      end
    end

    context 'when there are alternates' do
      before { allow(action_plan).to receive(:alternates) { [alternate] } }

      let(:alternate) { double(hreflang: locale, url: url) }
      let(:locale) { double }
      let(:url) { double }

      it 'returns a hash of locale => url pairs' do
        expect(subject.alternate_options).to include(locale => url)
      end
    end
  end

  describe '#canonical_url' do
    before { helpers.stub(action_plan_url: '/action_plans/bob') }

    it 'returns the path to the action plan' do
      expect(subject.canonical_url).to eq('/action_plans/bob')
    end
  end

  describe '#content' do
    let(:action_plan) do
      double(Core::ActionPlan,
             id:          'bob',
             title:       'uncle-bob-is-richer-than-you',
             description: 'uncle is rich',
             body:        MultiJson.load(File.read(fixture))['body'])
    end

    let(:html) { Nokogiri::HTML(decorator.content) }

    context 'when the object body needs processing' do
      let(:fixture) { 'spec/fixtures/action-plan.json' }

      it 'strips images from intro paragraphs' do
        expect(html.search(HTMLProcessor::INTRO_IMG)).to be_empty
      end

      it 'replaces action item h3s with h2s ' do
        h3_nodes = html.search('//div[@class="action-item"]/h3')
        h2_nodes = html.search('//div[@class="action-item"]/h2')

        expect(h3_nodes).to be_empty
        expect(h2_nodes).to_not be_empty
      end

      it 'replaces action item h4s with h3s ' do
        h4_nodes = html.search('//div[@class="action-item"]//h4')
        h3_nodes = html.search('//div[@class="action-item"]//h3')

        expect(h4_nodes).to be_empty
        expect(h3_nodes).to_not be_empty
      end
    end
  end
end
