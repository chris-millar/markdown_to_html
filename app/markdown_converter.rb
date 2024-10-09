require_relative 'link_converter.rb'
require_relative 'header_converter.rb'

class MarkdownConverter
  def self.to_html(converted)
    converted = LinkConverter.convert_links(converted)
    converted = HeaderConverter.convert_headers(converted)

    converted
  end
end