RSpec.describe SurviveJanuary, type: :helper do
  describe '#go_live?' do
    context 'before go live date' do
      it 'should be false' do
        expect(display_campaign_promo?).to be false
      end
    end

     context 'on go_live date' do
       it 'should be true' do
         allow(Date).to receive(:today) { Date.new(2015, 12, 28) }

         expect(display_campaign_promo?).to be true
       end
     end

     context 'after go_live date' do
       it 'should be true' do
         allow(Date).to receive(:today) { Date.new(2016, 1, 10) }

         expect(display_campaign_promo?).to be true
       end
     end
  end
end
