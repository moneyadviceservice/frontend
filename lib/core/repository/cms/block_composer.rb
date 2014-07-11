module Core::Repository
  module Cms
    # Recombines CMS blocks to emulate current public website repo.
    # TODO: replace with native support for displaying blocks outside of frontend core
    class BlockComposer
      class Block < OpenStruct; end

      attr_reader :blocks

      def initialize(blocks)
        @blocks = blocks.map {|block| Block.new(block) }
      end

      def find(id)
        Block.new(blocks.detect { |e| e['identifier'] == id })
      end

      def to_html
        find('content').content
      end
    end
  end
end