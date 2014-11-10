RSpec.describe Core::Repository::RecommendedTools::Static do
  subject { described_class.new(:budget_planner) }

  it 'loads tool content from yaml' do
    expect(subject.identifier).to eql(:budget_planner)
    expect(subject.title).to eql('Do you know where all your money goes each month?')
    expect(subject.subtitle).to eql('Most people find it hard to keep track of their costs without a budget.')
    expect(subject.link_copy).to eql('Work out your budget')
    expect(subject.link_url).to eql('link_url')
    expect(subject.description).to eql('Our budget planner helps you see where you’re spending and plan for unexpected bills.')

    expect(subject.completion_copy).to eql('101 people tracking their money.')
    expect(subject.time_to_complete).to eql('Takes 5 – 10 minutes')

    expect(subject.quotee_name).to eql('Debbie')
    expect(subject.quotee_location).to eql('London')
    expect(subject.quote).to eql('Our interactive calculators can help you manage your money and plan for the future.')
  end
end
