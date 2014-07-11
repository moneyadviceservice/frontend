module Core::Repository
  module Cms
    # Recombines CMS blocks to emulate current public website repo.
    # TODO: replace with native support for displaying blocks outside of frontend core
    class BlockComposer
      class Block < OpenStruct; end

      attr_reader :blocks

      def initialize(blocks=[])
        @blocks = Array(blocks)
      end

      def find(id)
        Block.new(blocks.detect { |block| block['identifier'] == id })
      end

      def to_html
        find('content').content.to_s
      end
    end
  end
end