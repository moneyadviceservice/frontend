module Core::Repository
  module CMS
    # Recombines CMS blocks to emulate current public website repo.
    # TODO: replace with native support for displaying blocks outside of frontend core
    class BlockComposer
      class Block < OpenStruct; end

      attr_reader :blocks, :parser

      def initialize(blocks=[], parser=Kramdown::Document)
        @blocks = Array(blocks)
        @parser = parser
      end

      def find(id)
        Block.new(blocks.detect { |block| block['identifier'] == id })
      end

      def to_html
        parser.new(find('content').content.to_s).to_html
      end
    end
  end
end