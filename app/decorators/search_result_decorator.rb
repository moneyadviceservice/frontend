class SearchResultDecorator < Draper::Decorator
  delegate :link

  def to_partial_path
    'search_result'
  end

  def title
    object.title.sub(Regexp.union(title_suffix_regexps), '').html_safe
  end

  def description
    object.description.gsub(/<br\s*\/?>/, '').html_safe
  end

  private

  def title_suffix_regexps
    title  = h.t('layouts.base.title')
    length = title.length

    length.times.map do |i|
      is_truncated = i < (length - 1)

      Regexp.new(' - %<suffix>s%<ellipsis>s$' % { suffix:   title[0..i],
                                                  ellipsis: is_truncated ? ' ...' : nil })
    end
  end
end
