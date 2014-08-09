module ApplicationHelper
  def heading_tag(text, options = {})
    heading_level = options[:heading_level]
    content_tag("h#{heading_level}", text, 'role' => :heading, 'aria-level' => heading_level)
  end

  def css(line_numbers: false, &block)
    source = strip_leading_indentation_from_source(capture(&block))
    tokens = Rouge::Lexers::CSS.lex(source)

    format_tokens_as_html(tokens, line_numbers)
  end

  def erb(line_numbers: false, &block)
    source = strip_leading_indentation_from_source(capture(&block))
    tokens = Rouge::Lexers::ERB.lex(source)

    format_tokens_as_html(tokens, line_numbers)
  end

  def html(line_numbers: false, &block)
    source = strip_leading_indentation_from_source(capture(&block))
    tokens = Rouge::Lexers::HTML.lex(source)

    format_tokens_as_html(tokens, line_numbers)
  end

  def scss(line_numbers: false, &block)
    source = strip_leading_indentation_from_source(capture(&block))
    tokens = Rouge::Lexers::Scss.lex(source)

    format_tokens_as_html(tokens, line_numbers)
  end

  def Terminal256(line_numbers: false, &block)
    source = strip_leading_indentation_from_source(capture(&block))
    tokens = Rouge::Lexers::HTML.lex(source)

    format_tokens_as_html(tokens, line_numbers)
  end

  def yaml(line_numbers: false, &block)
    source = strip_leading_indentation_from_source(capture(&block))
    tokens = Rouge::Lexers::YAML.lex(source)

    format_tokens_as_html(tokens, line_numbers)
  end

  def locale_class
    "theme-#{I18n.locale}" unless I18n.locale == :en
  end

  def translation?(key)
    I18n.translate!(key)
  rescue I18n::MissingTranslationData
    false
  end

  private

  def strip_leading_indentation_from_source(source)
    source.strip.gsub(/^[  ]{2}/, '')
  end

  def format_tokens_as_html(tokens, line_numbers)
    formatter = Rouge::Formatters::HTML.new(line_numbers: line_numbers)

    formatter.format(tokens).html_safe
  end
end
