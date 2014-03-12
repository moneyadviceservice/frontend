require 'spec_helper'
require 'core/entities/action_plan'

describe ActionPlanDecorator do
  subject(:decorator) { described_class.decorate(action_plan) }

  let(:action_plan) do
    double(Core::ActionPlan,
           id:          'bob',
           title:       'uncle-bob-is-richer-than-you',
           description: 'uncle is rich',
           body:        MultiJson.load(File.read(fixture))['body'])
  end

  describe '#content' do
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