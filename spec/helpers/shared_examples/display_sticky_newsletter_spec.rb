RSpec.shared_examples 'shuns_sticky_newsletter' do
   it 'does not show sticky newsletter' do
     expect(display_sticky_newsletter?).to be(false)
   end
end
