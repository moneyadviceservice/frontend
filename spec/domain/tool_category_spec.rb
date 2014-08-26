RSpec.describe ToolCategory do
  let(:category_id) { 'string-category-id' }
  let(:entity) { double }

  subject { described_class.new(category_id) }

  it { is_expected.to_not be_home }
  it { is_expected.to_not be_news }

  describe '#title' do
    let(:title) { double }

    before do
      allow(subject).to receive(:entity) { entity }
      allow(entity).to receive(:title) { title }
    end

    it 'returns the title of the entity' do
      expect(subject.title).to eql title
    end
  end

  describe '#entity' do
    before do
      allow(Core::CategoryReader).to receive(:new) { entity }
      allow(entity).to receive(:call)
    end

    it 'instantiates a new category reader with the category id' do
      expect(Core::CategoryReader).to receive(:new).with(category_id)
      subject.send(:entity)
    end

    it 'calls the new category reader' do
      expect(entity).to receive(:call)
      subject.send(:entity)
    end
  end
end
