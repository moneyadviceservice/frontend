RSpec.shared_examples 'displays_warning_banner' do
  it 'shows warning banner for impending budget changes' do
    Timecop.freeze(Chronic.parse(date)) do
      expect(display_banner_warning?).to be(true)
    end
  end
end

RSpec.shared_examples 'displays_banner_warning_for_whitelisted_tools' do
  let(:base_url) { 'www.example.com' }
  let(:request)  { double('request', url: url, base_url: base_url ) }

  it 'displays warning for whitelisted tools' do
    allow(BudgetWarning).to receive(:request).and_return(request)

    expect(described_class.whitelisted?).to be(true)
  end
end

RSpec.shared_examples 'displays_banner_warning_for_whitelisted_welsh_tools' do
  let(:base_url) { 'www.example.com' }
  let(:request)  { double('request', url: url, base_url: base_url ) }

  it 'displays warning in welsh for whitelisted tools' do
    allow(BudgetWarning).to receive(:request).and_return(request)

    expect(described_class.whitelisted?).to be(true)
  end
end

RSpec.shared_examples 'displays_banner_warning_for_whitelisted_welsh_nontools' do
  let(:base_url) { 'www.example.com' }
  let(:request)  { double('request', url: url, base_url: base_url ) }

  it 'displays warning in welsh for whitelisted tools' do
    allow(BudgetWarning).to receive(:request).and_return(request)

    expect(described_class.whitelisted?).to be(true)
  end
end
