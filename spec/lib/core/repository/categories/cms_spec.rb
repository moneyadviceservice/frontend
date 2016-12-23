RSpec.describe Core::Repository::Categories::CMS do
  describe '#all' do
    it 'returns lots of categories' do
      expected = [
        'debt-and-borrowing',
        'budgeting-and-managing-money',
        'saving-and-investing',
        'pensions-and-retirement',
        'work-and-redundancy',
        'benefits',
        'births-deaths-and-family',
        'insurance',
        'homes-and-mortgages',
        'care-and-disability',
        'cars-and-travel'
      ]

      result = subject.all
      expect(result.map { |h| h['id'] }).to eql(expected)
    end
  end

  describe '#find' do
    context 'when the category exists' do
      it 'returns the category' do
        result = subject.find('about-us')
        expect(result['id']).to eql('about-us')
      end
    end

    context 'when category does not exist' do
      it 'raises an exception' do
        expect { subject.find('idonotexist') }.to raise_error(Core::Repository::Base::RequestError)
      end
    end

    context 'when the category is redirected' do
      it 'returns a redirect' do
        expect { subject.find('types-of-retirement-income') }.to raise_error do |error|
          expect(error.status).to eql(301)
          expect(error.location).to eql('http://localhost:5000/en/categories/using-your-pension-pot')
        end
      end
    end
  end
end
