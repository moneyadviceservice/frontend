RSpec.describe Core::Repository::Categories::CMS do
  describe '#all' do
    it 'returns lots of categories' do
      expected = ["debt-and-borrowing",
        "budgeting-and-managing-money",
        "saving-and-investing",
        "work-pensions-and-retirement",
        "benefits",
        "births-deaths-and-family",
        "insurance",
        "homes-and-mortgages",
        "care-and-disability",
        "cars-and-travel"]

      VCR.use_cassette('/en/core/repository/categories/cms/all') do
        result = subject.all
        expect(result.map { |h| h['id'] }).to eql(expected)
      end
    end
  end

  describe '#find' do
    context 'when the category exists' do
      it 'returns the category' do
        VCR.use_cassette('/en/core/repository/categories/cms/find/about-us') do
          result = subject.find('about-us')
          expect(result['id']).to eql('about-us')
        end
      end
    end

    context 'when category does not exist' do
      it 'raises an exception' do
        VCR.use_cassette('/en/core/repository/categories/cms/find/idonotexist') do
          expect { subject.find('idonotexist') }.to raise_error(Core::Repository::Base::RequestError)
        end
      end
    end

    context 'when the category is redirected', features: [:redirects] do
      it 'returns a redirect'
    end
  end
end
