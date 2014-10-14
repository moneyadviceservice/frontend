require 'tool_mount_point/base'
require 'tool_mount_point/mortgage_calculator'

RSpec.describe ToolMountPoint::MortgageCalculator do

  describe '#alternate_tool_id' do
    context 'switching the tool id from english to its welsh aternative' do
      it { expect(subject.alternate_tool_id('mortgage-calculator')).to eq('cyfrifiannell-morgais') }
      it { expect(subject.alternate_tool_id('house-buying')).to eq('prynu-ty') }
    end

    context 'from welsh to its english' do
      it { expect(subject.alternate_tool_id('cyfrifiannell-morgais')).to eq('mortgage-calculator') }
      it { expect(subject.alternate_tool_id('prynu-ty')).to eq('house-buying') }
    end
  end

  describe '#alternate_url' do
    describe 'url without locale' do
      it 'returns the url untouched' do
        url = 'http://test.url/a/gibberish/url'
        expect(subject.alternate_url(url)).to eq(url)
      end
    end

    describe 'rewriting stamp duty tool urls' do
      it 'returns a correct looking url untampered' do
        locale = 'cy'
        url    = 'http://test.url/cy/tools/prynu-ty/cyfrifiannell-treth-stamp'
        expect(subject.alternate_url(url, locale)).to eq(url)
      end

      it 'rewrites the welsh ending url to english when locale is "en"' do
        locale = 'en'
        url    = 'http://test.url/en/tools/house-buying/cyfrifiannell-treth-stamp'
        expect(subject.alternate_url(url, locale)).to eq('http://test.url/en/tools/house-buying/stamp-duty-calculator')
      end

      it 'rewrites the english ending url to welsh when locale is "cy"' do
        locale = 'cy'
        url    = 'http://test.url/cy/tools/prynu-ty/stamp-duty-calculator'
        expect(subject.alternate_url(url, locale)).to eq('http://test.url/cy/tools/prynu-ty/cyfrifiannell-treth-stamp')
      end
    end

    describe 'rewriting mortgage affordability tool urls' do
      it 'returns a correct looking url untampered' do
        url    = 'http://test.url/cy/tools/prynu-ty/cyfrifiannell-fforddiadwyedd-morgais'
        expect(subject.alternate_url(url)).to eq(url)
      end

      it 'rewrites the welsh ending url to english when locale is "en"' do
        locale = 'en'
        url    = 'http://test.url/en/tools/house-buying/cyfrifiannell-fforddiadwyedd-morgais'
        expect(subject.alternate_url(url, locale)).to eq('http://test.url/en/tools/house-buying/mortgage-affordability-calculator')
      end

      it 'rewrites the english ending url to welsh when locale is "cy"' do
        locale = 'cy'
        url    = 'http://test.url/cy/tools/prynu-ty/mortgage-affordability-calculator'
        expect(subject.alternate_url(url, locale)).to eq('http://test.url/cy/tools/prynu-ty/cyfrifiannell-fforddiadwyedd-morgais')
      end
    end
  end

end
