require 'spec_helper'

describe EntityDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(entity) }

  let(:id) { 'bob' }
  let(:entity) { double(class: Core::Entity, id: id) }

  describe '#canonical_url' do
    before { helpers.stub(entity_url: "/entities/#{id}") }

    it 'returns the path to the article' do
      expect(subject.canonical_url).to eq("/entities/#{id}")
    end
  end
end
