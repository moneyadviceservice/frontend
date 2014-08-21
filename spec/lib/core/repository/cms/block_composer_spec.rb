module Core::Repository::CMS
  RSpec.describe BlockComposer do
    let(:id) { "content" }
    subject(:composer) { described_class.new(blocks, id) }

    let(:content_block) do
      { 'identifier' => 'content', 'content' => 'Content Block' }
    end

    describe '#initialize' do
      it 'accepts an array' do
        dub = double
        expect(described_class.new([dub]).blocks).to eql([dub])
      end

      it 'transforms a nil' do
        expect(described_class.new(nil).blocks).to eql([])
      end

      it 'transforms a non-nil non-array' do
        dub = double
        expect(described_class.new(dub).blocks).to eql([dub])
      end
    end

    describe '#to_s' do
      context 'description' do
        let(:blocks) { [{ 'identifier' => 'description', 'content' => 'meta description' }] }
        let(:id) { "description" }

        it 'returns the meta description string' do
          expect(composer.to_s).to eql("meta description")
        end
      end
    end

    describe '#to_html' do
      context 'content block provided' do
        let(:blocks) { [content_block] }

        it 'returns a composed html string' do
          expect(composer.to_html).to eql("<p>Content Block</p>\n")
        end
      end

      context 'no blocks provided' do
        let(:blocks) { [] }

        it 'is an empty string' do
          expect(composer.to_html).to eql("\n")
        end
      end

      context 'non-content block provided' do
        let(:non_content_block) do
          { 'identifier' => 'not_content', 'content' => 'Definitely not a Content Block' }
        end

        let(:blocks) { [non_content_block] }

        it 'returns a composed html string' do
          expect(composer.to_html).to eql("\n")
        end
      end

    end
  end
end
