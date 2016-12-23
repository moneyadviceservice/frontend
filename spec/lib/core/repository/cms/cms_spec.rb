module Core::Repository::CMS
  RSpec.describe Resource302Error do
    subject { described_class.new('https://example.com') }

    it 'stores location' do
      expect(subject.location).to eql('https://example.com')
    end

    it 'has a status of 302' do
      expect(subject.status).to eql(302)
    end

    it 'stores error message' do
      expect(subject.message).to eql('Core::Repository::CMS::Resource302Error')
    end
  end

  RSpec.describe CMS do
    subject do
      Class.new(CMS) do
        def resource_name
          'articles'
        end
      end.new
    end

    describe '#find' do
      context 'when article does not exist' do
        it 'returns nil' do
          expect(subject.find('no-exist')).to be_nil
        end
      end

      context 'when article exist' do
        it 'returns the article' do
          expect(subject.find('why-save-into-a-pension')).to_not be_nil
        end
      end

      context 'when cms is down or there was a problem' do
        let(:connection) do
          connection = double
          allow(connection).to receive(:get).and_raise
          connection
        end

        before :each do
          allow(subject).to receive(:connection) { connection }
        end

        it 'raises a request error' do
          expect { subject.find('server-down') }.to raise_error Core::Repository::Base::RequestError
        end
      end

      context 'when article is a 301 redirect' do
        it 'raises Resource301Error' do
          expect { subject.find('understanding-your-first-payslip') }.to raise_error Core::Repository::CMS::Resource301Error
        end

        it 'returns status of 301' do
          expect { subject.find('understanding-your-first-payslip') }.to raise_error do |error|
            expect(error.status).to eql(301)
          end
        end

        it 'returns location of redirect' do
          expect { subject.find('understanding-your-first-payslip') }.to raise_error do |error|
            expect(error.location).to eql('http://localhost:5000/en/articles/understanding-your-payslip')
          end
        end
      end

      context 'when article is a 302 redirect' do
        it 'raises Resource302Error' do
          expect { subject.find('pensions-for-the-self-employed') }.to raise_error Core::Repository::CMS::Resource302Error
        end

        it 'returns status of 302' do
          expect { subject.find('pensions-for-the-self-employed') }.to raise_error do |error|
            expect(error.status).to eql(302)
          end
        end

        it 'returns location of redirect' do
          expect { subject.find('pensions-for-the-self-employed') }.to raise_error do |error|
            expect(error.location).to eql('http://localhost:5000/en/articles/why-save-into-a-pension')
          end
        end
      end
    end
  end
end
