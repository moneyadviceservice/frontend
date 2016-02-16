RSpec.describe ChatMigrationMessage, type: :helper do
  describe '#display_chat_migration_message?' do

    context 'before display_message date' do
      it 'returns false' do
      	allow(Date).to receive(:today) { Date.new(2016, 2, 5) }
        expect(display_chat_migration_message?).to be false
      end
    end

    context 'on display_message date' do
      it 'returns true' do
        allow(Date).to receive(:today) { Date.new(2016, 2, 6) }
        expect(display_chat_migration_message?).to be true
       end
     end

     context 'after display_message date' do
       it 'returns false' do
         allow(Date).to receive(:today) { Date.new(2016, 2, 7) }
         expect(display_chat_migration_message?).to be false
       end
     end
  end
end
