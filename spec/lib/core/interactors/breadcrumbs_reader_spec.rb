require_relative 'shared_examples/optional_failure_block'
require 'core/interactors/breadcrumbs_reader'

RSpec.describe Core::BreadcrumbsReader do
  it { is_expected.to respond_to :call }

  describe '.call' do
    it_has_behavior 'optional failure block'
  end
end
