RSpec.describe User, type: :model do
  let(:attributes) do
    { email:                 'david@example.com',
      password:              'password',
      first_name:            'david',
      post_code:             'NE1 6EE'
    }
  end

  subject { described_class.new(attributes) }

  describe 'default values' do
    context 'create a new user record' do
      it 'opt_in_for_research should be false' do
        expect(subject.opt_in_for_research).to be_falsey
      end
    end
  end


  describe '#fake_send_confirmation_email' do
    it 'sends a fake confirmation email when user is saved' do
      subject.save!
      expect(subject.confirmation_sent_at).to_not be_nil
    end
  end

  describe 'validations' do
    it { is_expected.to allow_value('PasswordWithMoreThan8Characters').for(:password) }
    it { is_expected.to allow_value('P@55word').for(:password) }
    it { is_expected.to allow_value('12345678').for(:password) }
    it { is_expected.to allow_value('ABCDEFGH').for(:password) }
    it { is_expected.to allow_value('$$$$$$$$').for(:password) }

    it { is_expected.not_to allow_value('').for(:password) }
    it { is_expected.not_to allow_value('123').for(:password) }
    it { is_expected.not_to allow_value('2$hOrt').for(:password) }

    it { is_expected.to allow_value('m.fait@thoughtwork.com').for(:email) }
    it { is_expected.to allow_value('m@t.com').for(:email) }
    it { is_expected.not_to allow_value('invalid@dress').for(:email) }
    it { is_expected.not_to allow_value('inv@lid@dress.com').for(:email) }

    it { is_expected.to allow_value('Michael').for(:first_name) }
    it { is_expected.not_to allow_value('TWENTY  FIVE   CHARACTERS').for(:first_name) }
    it { is_expected.to allow_value('TWENTY  FOUR  CHARACTERS').for(:first_name) }
    it { is_expected.not_to allow_value('TWENTY  FIVE   CHARACTERS').for(:last_name) }
    it { is_expected.to allow_value('TWENTY  FOUR  CHARACTERS').for(:last_name) }
    it { is_expected.to allow_value('M F').for(:first_name) }
    it { is_expected.to allow_value('Michael S.').for(:first_name) }
    it { is_expected.not_to allow_value('').for(:first_name) }
    it { is_expected.not_to allow_value(' ').for(:first_name) }
    it { is_expected.not_to allow_value("\t").for(:first_name) }

    it { validate_uniqueness_of(:email) }

    it { is_expected.not_to allow_value('WC11 $123').for(:post_code) }
    it { is_expected.not_to allow_value('WC1!123').for(:post_code) }
    it { is_expected.not_to allow_value('WC1%&*123').for(:post_code) }
    it { is_expected.not_to allow_value('W').for(:post_code) }
    it { is_expected.not_to allow_value('12345678901').for(:post_code) }
    it { is_expected.not_to allow_value('').for(:post_code) }
    it { is_expected.to allow_value('EC1N 2TD').for(:post_code) }
    it { is_expected.to allow_value('EC4 6NW').for(:post_code) }
    it { is_expected.to allow_value('N7 0HS').for(:post_code) }

    it { is_expected.to allow_value('male').for(:gender) }
    it { is_expected.to allow_value('female').for(:gender) }
    it { is_expected.not_to allow_value('').for(:gender) }
    it { is_expected.not_to allow_value('other').for(:gender) }
    it { is_expected.to allow_value(nil).for(:gender) }

    it { is_expected.to allow_value('0-15').for(:age_range) }
    it { is_expected.to allow_value('16-17').for(:age_range) }
    it { is_expected.to allow_value('18-20').for(:age_range) }
    it { is_expected.to allow_value('21-24').for(:age_range) }
    it { is_expected.to allow_value('25-34').for(:age_range) }
    it { is_expected.to allow_value('35-44').for(:age_range) }
    it { is_expected.to allow_value('45-54').for(:age_range) }
    it { is_expected.to allow_value('55-64').for(:age_range) }
    it { is_expected.to allow_value('65-74').for(:age_range) }
    it { is_expected.to allow_value('75+').for(:age_range) }
    it { is_expected.not_to allow_value('').for(:age_range) }
    it { is_expected.not_to allow_value('15-21').for(:age_range) }
    it { is_expected.to allow_value(nil).for(:age_range) }

    it { is_expected.to allow_value(nil).for(:date_of_birth) }
    it { is_expected.not_to allow_value(Date.today).for(:date_of_birth) }
    it { is_expected.to allow_value(1.days.ago).for(:date_of_birth) }
    it { is_expected.to allow_value('31/12/1970').for(:date_of_birth) }
    it { is_expected.not_to allow_value('31/02/1970').for(:date_of_birth) }

    it { is_expected.to allow_value(nil).for(:contact_number) }
    it { is_expected.to allow_value('01005005000').for(:contact_number) }
    it { is_expected.to allow_value('02005005000').for(:contact_number) }
    it { is_expected.to allow_value('03005005000').for(:contact_number) }
    it { is_expected.to allow_value('07005005000').for(:contact_number) }
    it { is_expected.not_to allow_value('09005005000').for(:contact_number) }
    it { is_expected.not_to allow_value('5000').for(:contact_number) }
    it { is_expected.not_to allow_value('0900500500090').for(:contact_number) }

    it 'allows update with blank password' do
      user = FactoryGirl.create(:user)
      user = User.first
      user.first_name = 'Philip'
      expect { user.save! }.to_not raise_error
    end
  end

  it 'should upcase post code' do
    user = User.create!(attributes.merge(post_code: 'n7 0hs'))
    expect(user.post_code).to eq('N7 0HS')
  end

  describe '#registered?' do
    context 'when user has accepted TCs' do
      it 'returns true' do
        subject.accept_terms_conditions = 1
        expect(subject.registered?).to eql(true)
      end
    end

    context 'when user has not accepted TCs' do
      it 'returns false' do
        expect(subject.registered?).to eql(false)
      end
    end
  end

  describe '#invitation_sent?' do
    context 'when an invite has been sent' do
      it 'returns true' do
        subject.invitation_sent_at = 1.minute.ago
        expect(subject.invitation_sent?).to be(true)
      end
    end

    context 'when an invite has not been sent' do
      it 'returns false' do
        expect(subject.invitation_sent?).to be(false)
      end
    end
  end

  describe '#invited_by' do
    context 'invited by someone' do
      it 'returns truthy' do
        subject.invited_by_id = 123
        expect(subject.invited_by).to be_truthy
      end
    end

    context 'not invited by someone' do
      it 'returns falsey' do
        expect(subject.invited_by).to be_falsey
      end
    end
  end

  describe '#send_devise_notification' do
    it 'adds the job to the mailjet queue' do
      subject.save!

      expect do
        subject.send_reset_password_instructions
      end.to change { Delayed::Job.where(queue: 'frontend_email').count }.by(1)
    end

    context 'when the job runs', features: [:sign_in, :reset_passwords] do
      it 'sends an email' do
        subject.save!
        subject.send_reset_password_instructions

        expect do
          Delayed::Job.last.payload_object.perform
        end.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end

  describe '#data_for?' do
    context 'when no tool specific method exists' do
      it 'returns nil' do
        expect(subject.data_for?(:no_tool)).to be_nil
      end
    end

    context 'when a tool specific method exists' do
      let(:tool_name) { :money_tool }
      let(:has_data) { true }

      before do
        allow(subject).to receive(:"data_for_#{tool_name}?").and_return(has_data)
      end

      it 'returns the value from that method' do
        expect(subject.data_for?(:money_tool)).to eql(has_data)
      end
    end
  end
end
