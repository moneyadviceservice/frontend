require 'spec_helper'

RSpec.describe Referer, :type => :controller do
  controller do
    include Referer

    def index
      head :ok
    end
  end

  describe '#referer' do
    context 'when no referer' do
      it 'returns nil' do
        get :index
        expect(controller.referer).to be_nil
      end
    end

    context 'when referer is mas' do
      it 'returns referer' do
        referer = 'https://www.moneyadviceservice.org.uk/en/hello'
        request.env["HTTP_REFERER"] = referer
        get :index

        expect(controller.referer).to eql(referer)
      end

      it 'returns referer' do
        referer = 'https://moneyadviceservice.org.uk/en/hello'
        request.env["HTTP_REFERER"] = referer
        get :index

        expect(controller.referer).to eql(referer)
      end
    end

    context 'when referer is external to mas' do
      it 'returns nil' do
        referer = 'https://www.google.com'
        request.env["HTTP_REFERER"] = referer
        get :index

        expect(controller.referer).to be_nil
      end
    end
  end
end
