module ApplicationHelper
  def html(&block)
    source    = capture(&block).strip.gsub(/^[  ]{2}/, '')
    tokens    = Rouge::Lexers::HTML.lex(source)
    formatter = Rouge::Formatters::HTML.new(line_numbers: true)

    formatter.format(tokens).html_safe
  end
end
