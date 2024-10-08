require_relative 'link_converter.rb'

class MarkdownConverter
  def self.to_html(converted)
    converted = LinkConverter.convert_links(converted)

    converted
  end
end