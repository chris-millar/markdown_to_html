class HeaderConverter
  HEADER_REGEX = /^(?<header_size>\#{1,6}) (?<header_content>[\S ]+)/

  def self.convert_headers(converted)
    converted.gsub(HEADER_REGEX) do |match|
      match_data = match.match(HEADER_REGEX)
      header_size = match_data[:header_size].length

      "<h#{header_size}>#{match_data[:header_content].strip}</h#{header_size}>"
    end
  end
end