require_relative '../../spec_helper'

describe Localisation do
  controller do
    include Localisation

    public :alternative_locales

    def index
      head :ok
    end
  end

  describe 'setting locale' do
    context 'when the locale is unknown' do
      it 'returns a not found status' do
        expect { get :index, locale: 'unknown' }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'when the locale is not specified' do
      it 'sets the locale to the specified' do
        expect(I18n).to receive(:locale=).with(I18n.default_locale)

        get :index
      end
    end

    context 'when the locale is specified as a param' do
      it 'sets the locale to the specified' do
        expect(I18n).to receive(:locale=).with('cy')

        get :index, locale: 'cy'
      end
    end
  end

  describe 'alternative locales' do
    it 'returns an array of locals excluding the current locale' do
      allow(I18n).to receive(:locale).and_return(:en)
      allow(I18n).to receive(:available_locales).and_return(%I(en cy))

      expect(controller.alternative_locales).to eql(%I(cy))
    end
  end
end
