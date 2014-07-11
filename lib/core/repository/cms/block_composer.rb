module Core::Repository
  module Cms
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