RSpec.describe ChatOpeningHoursDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(opening_hours) }

  describe '#periods' do
    subject { decorator.periods }

    context 'when open each day for the same hours' do
      let(:opening_hours) { OpeningHours.new('9:00 AM', '5:00 PM') }

      it 'returns the days and hours open as one period' do
        is_expected.to include('Monday to Sunday, 9am to 5pm')
      end
    end

    context 'when open each day for different hours' do
      let(:opening_hours) do
        OpeningHours.new('9am', '5pm').tap do |opening_hours|
          opening_hours.update(:sun, '10:00 AM', '10:00 PM')
        end
      end

      it 'returns the days and hours open as multiple periods' do
        is_expected.to include('Monday to Saturday, 9am to 5pm', 'Sunday, 10am to 10pm')
      end
    end
  end
end
