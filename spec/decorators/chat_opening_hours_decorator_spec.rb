RSpec.describe ChatOpeningHoursDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(opening_hours) }

  describe '#periods' do
    subject { decorator.periods }

    context 'when open each day for the same hours' do
      let(:opening_hours) { OpeningHours.new('9:00 AM', '5:00 PM') }

      it 'returns the days and hours open as one period' do
        is_expected.to include('Monday to Sunday, 9am&nbsp;to&nbsp;5pm')
      end
    end

    context 'when open each day for different hours' do
      let(:opening_hours) do
        OpeningHours.new('9am', '5pm').tap do |opening_hours|
          opening_hours.update(:sun, '10:00 AM', '10:00 PM')
        end
      end

      it 'returns the days and hours open as multiple periods' do
        is_expected.to include('Monday to Saturday, 9am&nbsp;to&nbsp;5pm',
                               'Sunday, 10am&nbsp;to&nbsp;10pm')
      end
    end
  end

  describe '#open_periods' do
    subject { decorator.open_periods }

    let(:opening_hours) do
      OpeningHours.new('9am', '5pm').tap do |opening_hours|
        opening_hours.closed(:sun)
      end
    end

    it 'excludes closed days' do
      expect(subject.size).to eql(1)
      is_expected.to include('Monday to Saturday, 9am&nbsp;to&nbsp;5pm')
    end
  end

  describe '#next_period_hours' do
    subject { decorator.next_period_hours }

    context 'when open each day for the same hours' do
      let(:opening_hours) { OpeningHours.new('9:00 AM', '5:00 PM') }

      it 'returns the hours open' do
        is_expected.to eq('9am&nbsp;to&nbsp;5pm')
      end
    end

    context 'when open each day for different hours' do
      let(:opening_hours) do
        OpeningHours.new('9am', '5pm').tap do |opening_hours|
          opening_hours.update(:sun, '10:00 AM', '10:00 PM')
        end
      end

      after { Timecop.return }

      context 'when open later that day' do
        before { Timecop.travel(Chronic.parse('Tuesday 5am')) }

        it 'returns the hours open that day' do
          is_expected.to eq('9am&nbsp;to&nbsp;5pm')
        end
      end

      context 'when open tomorrow' do
        before { Timecop.travel(Chronic.parse('Saturday 11pm')) }

        it 'returns the hours open that day' do
          is_expected.to eq('10am&nbsp;to&nbsp;10pm')
        end
      end
    end
  end
end
