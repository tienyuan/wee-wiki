module ApplicationHelper
  def show_markdown_html(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = { strikethrough: true, highlight: true, underline: true, quote: true }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end
end
