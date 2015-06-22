RSpec.describe Core::Repository::RecommendedTools::Static do
  let(:tool_name) { :budget_planner }
  subject(:tool) { described_class.new(tool_name) }

  describe '#identifier' do
    it 'returns content from yaml' do
      expect(tool.identifier).to eql(:budget_planner)
    end
  end

  describe '#title' do
    it 'returns content from yaml' do
      expect(tool.title).to eql('Do you know where all your money goes each month?')
    end
  end

  describe '#subtitle' do
    let(:subtitle) do
      'Most people find it hard to keep track of their spending without a budget.'
    end

    it 'returns content from yaml' do
      expect(tool.subtitle).to eql(subtitle)
    end
  end

  describe '#copy' do
    it 'returns content from yaml' do
      expect(tool.link_copy).to eql('Plan your spending')
    end
  end

  describe '#link_url' do
    it 'returns content from yaml' do
      expect(tool.link_url).to eql('/en/tools/budget-planner/')
    end
  end

  describe '#description' do
    it 'returns content from yaml' do
      expect(tool.description).to eql('Our budget planner helps you see where ' \
                                         'you’re spending and plan for unexpected bills.')
    end
  end

  describe '#time_to_complete' do
    it 'returns content from yaml' do
      expect(tool.time_to_complete).to eql('Takes 5 – 10 minutes')
    end
  end

  describe '#quotee_name' do
    it 'returns content from yaml' do
      expect(tool.quotee_name).to eql('Debbie')
    end
  end

  describe '#quotee_location' do
    it 'returns content from yaml' do
      expect(tool.quotee_location).to eql('London')
    end
  end

  describe '#quote' do
    context 'when the locale exists' do
      it 'loads tool content from yaml' do
        expect(tool.quote).to eql('I loved the budget planner. I was able to easily ' \
                                     'manipulate my figures until I was in the clear.')
      end
    end

    context 'when the locale does not exist' do
      let(:tool_name) { :redundancy_plan }

      it 'returns empty string' do
        expect(tool.quote).to eq ''
      end
    end
  end
end
