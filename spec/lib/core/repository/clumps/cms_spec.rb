RSpec.describe Core::Repository::Clumps::CMS do
  describe '#all' do
    let(:expected_clump_names) do
      [
        'Debt & Borrowing',
        'Homes & Mortgages',
        'Managing Money',
        'Work, Benefits & Pension',
        'Family',
        'Cars & Travel',
        'Insurance'
      ]
    end

    it 'returns the expected clumps' do
      result = subject.all
      expect(result.map { |h| h['name'] }).to eql(expected_clump_names)
    end
  end
end
