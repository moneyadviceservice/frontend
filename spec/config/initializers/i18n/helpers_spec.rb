require 'spec_helper'

describe I18n do
  describe '.valid_locales' do
    it 'returns available locales without root' do
      expect(I18n.valid_locales).to_not include(:root);
    end
  end
end
