RSpec.describe Questions, type: :model do
  include Symbols

  shared_examples 'regionally valid content' do
    it 'displays the appropriate heading and content' do
      expect(results).to include({
        "section_code" => section_code,
        "headings" => array_including(
          hash_including({
            "heading_code"=>heading_code,
            "content"=>"#{corona_specific_content ? 'coronavirus-' : ''}#{content_prefix}-#{country}"
          })
        )
      })
    end
  end

  shared_examples 'valid content' do
    it 'displays the appropriate heading and content' do
      expect(results).to include({
        "section_code" => section_code,
        "headings" => array_including(
          hash_including({
            "heading_code"=>heading_code,
            "content"=>"#{corona_specific_content ? 'coronavirus-' : ''}#{content_prefix}"
          })
        )
      })
    end
  end

  shared_examples 'country specific content' do
    let(:model) { build("#{section}_#{country}_#{content_prefix}".gsub('-', '_').to_sym) }
    let(:results) { model.results }

    include_examples 'regionally valid content'
  end

  shared_examples 'uk specific content' do
    let(:model) { build("#{section}_#{country}_#{content_prefix}".gsub('-', '_').to_sym) }
    let(:results) { model.results }

    include_examples 'valid content'
  end

  shared_examples 'country agnostic content' do
    let(:model) { build("#{section}_#{content_prefix}".gsub('-', '_').to_sym) }
    let(:results) { model.results }

    include_examples 'valid content'
  end

  shared_examples 'urgent action country specific' do
    context 'Urgent action' do
      let(:section) {'urgent_action'}
      let(:section_code) { 'S1' }

      describe  'free debt advice' do
        let(:heading_code) { 'H1' }
        let(:content_prefix) {"debt-advice"}
        let(:corona_specific_content) {true}

        include_examples 'country specific content' do
        end
      end

      describe  'StepChange' do
        let(:heading_code) { 'H2' }
        let(:content_prefix) {'stepchange-debt'}
        let(:corona_specific_content) {true}

        include_examples 'country specific content' do
        end
      end

    end
  end

  shared_examples 'urgent action uk' do
    context 'Urgent action' do
      let(:section) {'urgent_action'}
      let(:section_code) { 'S1' }

      describe  'DebtLine' do
        let(:heading_code) { 'H3' }
        let(:content_prefix) {'self-employed-debt-advice'}
        let(:corona_specific_content) {true}

        include_examples 'uk specific content' do
        end
      end
    end
  end

  shared_examples 'urgent action northern ireland' do
    context 'Urgent action' do
      let(:section) {'urgent_action'}
      let(:section_code) { 'S1' }

      describe  'DebtLine' do
        let(:heading_code) { 'H3' }
        let(:content_prefix) {'self-employed-debt-advice'}
        let(:corona_specific_content) {true}

        include_examples 'country specific content' do
        end
      end
    end
  end

  #TODO: These are all positive tests. need to add negative tests
  #(i.e. test that checks content is not displayed under a condition that shoud result in it not displaying)
  context 'England' do
    let(:country) { 'england' }
    include_examples 'urgent action country specific'
    include_examples 'urgent action uk'
  end

  context 'Scotland' do
    let(:country) { 'scotland' }
    include_examples 'urgent action country specific'
    include_examples 'urgent action uk'
  end

  context 'Northern Ireland' do
    let(:country) { 'ni' }
    include_examples 'urgent action country specific'
    include_examples 'urgent action northern ireland'
  end

  context 'Wales' do
    let(:country) { 'wales' }
    include_examples 'urgent action country specific'
    include_examples 'urgent action uk'
  end

  describe 'All' do

    context 'Urgent action' do
      let(:section) {'urgent_action'}
      let(:section_code) { 'S1' }

      describe  'Pensions' do
        let(:heading_code) { 'H4' }
        let(:content_prefix) {'urgent-pension-advice'}
        let(:corona_specific_content) {false}

        include_examples 'country agnostic content'
      end
    end
  end

end
