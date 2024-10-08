class LinkConverter
  LINK_REGEX = /\[(?<link_text>.+)\]\((?<url>(https?:\/\/)?([\w]+\.)(\.?[\w]{2,})+(\?.*)?)\)/i

  def self.convert_links(converted)
    converted = converted.gsub(LINK_REGEX) do |match|
      match_data = match.match(LINK_REGEX)

      "<a href=\"#{match_data[:url]}\">#{match_data[:link_text]}</a>"
    end

    converted
  end
end