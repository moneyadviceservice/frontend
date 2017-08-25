RSpec.describe GeneralEnquiry, type: :model do
  let(:enquiry) { GeneralEnquiry.new }

  let(:data) do
    {
      title: GeneralEnquiry::TITLES.first,
      first_name: 'firstname',
      surname: 'lastname',
      email: 'firstname.lastname@example.com',
      type: GeneralEnquiry::TYPES.first,
      subject: GeneralEnquiry::SUBJECTS.first,
      message: 'This is a valid message for an enquiry'
    }
  end

  it 'accepts valid data' do
    enquiry.assign_attributes(data)
    expect(enquiry).to be_valid
  end

  describe 'data validation' do
    after(:each) do
      enquiry.assign_attributes(data)
      expect(enquiry).not_to be_valid
    end

    it 'first_name must exist' do
      data[:first_name] = ''
    end
    it 'surname must exist' do
      data[:surname] = ''
    end
    it 'email must be valid' do
      data[:email] = 'notvalidemail'
    end
    it 'title must be in TITLES' do
      data[:title] = 'invalid'
    end
    it 'type must be in TYPES' do
      data[:type] = 'invalid'
    end
    it 'subject must be in SUBJECTS' do
      data[:subject] = 'invalid'
    end
  end

  it 'defines 5 valid enquiry types' do
    expect(GeneralEnquiry::TYPES.count).to eq(5)
  end

  it 'defines 12 valid subjects' do
    expect(GeneralEnquiry::SUBJECTS.count).to eq(12)
  end

  it 'defines 6 valid enquiry titles' do
    expect(GeneralEnquiry::TITLES.count).to eq(6)
  end

  it 'responds false to persisted?' do
    expect(enquiry).not_to be_persisted
  end
end
