require 'spec_helper'

describe ErrorsController do
  describe 'GET #show' do
    %w(404 500).each do |error|
      context "when status is #{error}" do
        specify do
          get :show, status: error

          expect(response).to be_ok
        end
      end
    end
  end
end
