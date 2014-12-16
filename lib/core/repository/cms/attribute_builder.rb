module Core::Repository
  module CMS
    class AttributeBuilder
      def self.build(response)
        attributes = response.body

        attributes['title']       = attributes['label']
        attributes['body']        = BlockComposer.new(attributes['blocks']).to_html
        attributes['description'] = attributes['meta_description']
        attributes['categories']  = attributes['category_names']
        attributes['alternates']  = []
        attributes['related_content'] = { 'popular_links' => [
                                            {
                                              'title' => 'Get some help with debt.',
                                              'path' => '#'
                                            },
                                            {
                                              'title' => 'Get some help with credit cards.',
                                              'path' => '#'
                                            },
                                            {
                                              'title' => 'Calculate how to get more money.',
                                              'path' => '#'
                                            }
                                          ]
                                        }

        attributes
      end
    end
  end
end
