require_relative '../shared_examples/cms_resource'

module Core::Repository::Corporate
  RSpec.describe CMS do
    it_behaves_like 'a cms resource' do
      let(:resource_name) { 'corporate' }
    end
  end
end
