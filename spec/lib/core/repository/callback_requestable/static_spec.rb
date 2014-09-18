require 'spec_helper'

RSpec.describe Core::Repository::CallbackRequestable::Static do
  describe '#call' do
    context 'when it is callback requestable' do
      subject { described_class.new(Core::Article.new('managing-your-money-if-your-job-is-at-risk')) }

      it 'returns true' do
        expect(subject.call).to be_truthy
      end
    end

    context 'when it is not callback requestable' do
      subject { described_class.new(Core::Article.new('no-callback')) }

      it 'returns false' do
        expect(subject.call).to be_falsey
      end
    end
  end
end
