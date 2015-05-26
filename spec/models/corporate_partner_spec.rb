RSpec.describe CorporatePartner, type: :model do
  subject { create(:corporate_partner) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:tool_name) }
  it { is_expected.to respond_to(:tool_language) }
  it { is_expected.to respond_to(:tool_width_unit) }
  it { is_expected.to respond_to(:tool_width) }

  it { is_expected.to be_valid }

  describe 'validations' do

    context 'when name is not present' do
      before { subject.name = ' ' }

      it { is_expected.to validate_presence_of(:name) }
    end

    context 'when email is not present' do
      before { subject.email = ' ' }

      it { is_expected.to validate_presence_of(:email) }
    end

    context 'when tool width is not present' do
      before { subject.tool_width = ' ' }

      it { is_expected.to validate_presence_of(:tool_width) }
    end

    it { is_expected.to allow_value('Fake Org').for(:name) }
    it { is_expected.not_to allow_value('').for(:name) }

    it { is_expected.to allow_value('example@domain.com').for(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.not_to allow_value('inv@lid@dress.com').for(:email) }

    it { is_expected.to allow_value('Sample Tool').for(:tool_name) }
    it { is_expected.not_to allow_value(' ').for(:tool_name) }

    it { is_expected.to allow_value('en').for(:tool_language) }
    it { is_expected.to allow_value('cy').for(:tool_language) }
    it { is_expected.not_to allow_value(' ').for(:tool_language) }

    it { is_expected.to allow_value('px').for(:tool_width_unit) }
    it { is_expected.to allow_value('%').for(:tool_width_unit) }
    it { is_expected.not_to allow_value(' ').for(:tool_width_unit) }

    it { is_expected.to validate_numericality_of(:tool_width) }
    it { is_expected.to allow_value(300).for(:tool_width) }
    it { is_expected.not_to allow_value(-22).for(:tool_width) }
    it { is_expected.not_to allow_value('wewe').for(:tool_width) }
    it { is_expected.not_to allow_value(' ').for(:tool_width) }

    it { is_expected.to be_valid }

    describe '#tool_id' do
      it 'should return a hyphanated version of the tool name' do
        expect(subject.tool_id).to eq('sample-tool')
      end
    end

    describe '#tool_slug' do
      it 'should return a slug of the tool' do
        expect(subject.tool_slug).to eq('sample-tool-syndication')
      end
    end

    describe '#total_tool_width' do
      it 'should the full width with units' do
        expect(subject.total_tool_width).to eq('500px')
      end
    end

  end
end
