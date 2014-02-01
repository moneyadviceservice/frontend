require 'spec_helper'

describe I18n do
  describe '.valid_locales' do
    it 'returns available locales without root' do
      expect(I18n.valid_locales).to_not include(:root);
    end
  end

  describe '.with_locale' do
    let(:current_locale) { I18n.locale }
    let(:prob) { lambda{ I18n.locale } }

    it 'change locale value for the block' do
      expect(I18n.with_locale(:cy, &prob)).to eq(:cy)
    end

    it 'returns locale to the previous value' do
      I18n.with_locale(:cy, &prob)

      expect(I18n.locale).to eq(current_locale)
    end
  end
end
