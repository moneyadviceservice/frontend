RSpec.shared_examples 'valid content' do
  it 'displays the appropriate heading and content' do
    allow_any_instance_of(MoneyNavigator::Questions).to receive(:cms_content) {|me, slug| "#{ slug }"}
    results =  model.results
    expect(results).to include({
      "section_code" => section_code,
      "headings" => array_including(
        hash_including({
          "heading_code"=>heading_code,
          "content"=>hash_including({url: "#{url}"})
        })
      )
    })
  end
end

RSpec.shared_examples 'regionally valid content for regional rule' do
  let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".gsub('-', '_').to_sym, target_region: region ) }
  let(:url) { "coronavirus-#{content_prefix}" }

  include_examples 'valid content'
end

RSpec.shared_examples 'nationally valid content for national rule' do
  let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}_#{region}".gsub('-', '_').to_sym, target_region: [ region ]) }
  let(:url) { "coronavirus-#{content_prefix}-#{region}" }

  include_examples 'valid content'
end

RSpec.shared_examples 'nationally valid content for regional rule' do
  let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".gsub('-', '_').to_sym, target_region: [ region ]) }
  let(:url) { "coronavirus-#{content_prefix}-#{region}" }

  include_examples 'valid content'
end
