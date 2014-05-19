class SearchResultDecorator < Draper::Decorator
  delegate :description

  def to_partial_path
    'search_result'
  end

  def path
    object.link
  end

  def title
    object.title.sub(site_title_regex, '')
  end

  private

  def site_title_regex
    Regexp.new(site_title_suffixes.join('$|'))
  end

  def site_title_suffixes
    title  = h.t('layouts.base.title')
    length = title.length

    length.times.map do |i|
      truncated = i < length -1
      " - #{title[0..i]}" + (truncated ? ' ...' : '')
    end
  end

end
