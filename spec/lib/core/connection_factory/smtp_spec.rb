RSpec.describe Core::ConnectionFactory::Smtp, '.build' do
  let(:smtp_server) { double }
  let(:connection) { double }
  let(:options) { double }

  subject(:factory) { described_class.build(options) }

  before do
    allow(Core::ConnectionFactory::PseudoSmtpServer).to receive(:new) { smtp_server }
    allow(Core::Connection::Smtp).to receive(:new) { connection }
  end

  it 'creates a pseudo smtp server connection with the passed in options' do
    allow(Core::ConnectionFactory::PseudoSmtpServer).to receive(:new).with(options)
    subject
  end

  it 'instantiates the smtp connection with the pseduo smtp server connection' do
    expect(Core::Connection::Smtp).to receive(:new).with(smtp_server)
    subject
  end

  it 'returns the smtp connection' do
    expect(factory).to eql connection
  end
end

RSpec.describe Core::ConnectionFactory::PseudoSmtpServer do
  let(:from_address) { double }
  let(:mail) { Mail.new }
  let(:config) { double }
  subject(:smtp_server) { described_class.new(from_address: from_address, mail: mail, config: config) }

  it 'assigns the from address provided on initialization to the from_address attribute' do
    expect(subject.from_address).to eql from_address
  end

  describe '#deliver' do
    let(:recipient) { 'foo@bar.com' }
    let(:email_subject) { 'foo' }
    let(:body) { 'Foo bar.' }
    let(:delivery_method) { :smtp }
    let(:delivery_errors) { false }
    let(:config) do
      double(feedback_delivery_method: delivery_method, raise_feedback_delivery_errors: delivery_errors)
    end

    let(:message_details) do
      {
        recipient: recipient,
        subject: email_subject,
        body: body
      }
    end

    it 'sets the delivery method' do
      expect(mail).to receive(:delivery_method).with(delivery_method).and_call_original
      subject.deliver(message_details)
    end

    it 'sets the delivery errors' do
      expect(mail).to receive(:raise_delivery_errors=).with(delivery_errors).and_call_original
      subject.deliver(message_details)
    end

    it 'sets the from address on the mailer' do
      expect(mail).to receive(:from=).with(from_address).and_call_original
      subject.deliver(message_details)
    end

    it 'sets the to address on the mailer' do
      expect(mail).to receive(:to=).with(recipient).and_call_original

      subject.deliver(message_details)
    end

    it 'sets the subject on the mailer' do
      expect(mail).to receive(:subject=).with(email_subject).and_call_original
      subject.deliver(message_details)
    end

    it 'sets the body on the mailer' do
      expect(mail).to receive(:body=).with(body).and_call_original

      subject.deliver(message_details)
    end
  end
end
