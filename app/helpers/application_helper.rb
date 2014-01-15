module ApplicationHelper
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

  private

  def strip_leading_indentation_from_source(source)
    source.strip.gsub(/^[  ]{2}/, '')
  end

  def format_tokens_as_html(tokens, line_numbers)
    formatter = Rouge::Formatters::HTML.new(line_numbers: line_numbers)

    formatter.format(tokens).html_safe
  end
end
