RSpec.shared_examples 'displays_warning_banner' do
  it 'shows warning banner for impending budget changes' do
    expect(self).to receive(:whitelisted?).and_return(true)
    Timecop.freeze(Chronic.parse(date)) do
      expect(display_banner_warning?).to be(true)
    end
  end
end
