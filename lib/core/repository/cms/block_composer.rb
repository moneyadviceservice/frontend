module Core::Repository
  module CMS
    class BlockComposer
      class Block < OpenStruct
        delegate :to_s, to: :content
      end

      attr_reader :blocks, :id

      def initialize(blocks = [], id = 'content')
        @blocks = Array(blocks)
        @id = id
      end

      def find(id)
        Block.new(blocks.find { |block| block['identifier'] == id })
      end

      def to_html
        to_s
      end

      def to_s
        find(id).to_s
      end
    end
  end
end
