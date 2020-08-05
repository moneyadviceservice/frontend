RSpec.shared_examples 'valid content' do
  it 'displays the appropriate heading and content' do
    allow_any_instance_of(Questions).to receive(:cms_content) {|me, slug| "#{ slug }"}
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
