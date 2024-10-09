class ParagraphConverter
  HEADER_REGEX = /<h[1-6]>/

  # Split the content by line and iterate over each line; look to see if the line is either a terminating line
  # (blank line, header line, or end of content) otherwise it is content and will be collected until a terminating line is hit.
  # Once a terminating line is hit and there is collected content, that content will be converted into a paragraph
  # tag. This continue until all content has been iterated through.
  def self.convert_paragraphs(content)
    remaining_lines = content.lines
    new_content = ""
    collected_paragraph = []

    while remaining_lines.size > 0 do
      line = remaining_lines.shift
      if can_close_paragraph?(line, collected_paragraph)
        new_content += convert_to_paragraph(collected_paragraph) + line
        collected_paragraph = []
      elsif collect?(line)
        collected_paragraph << line
      else
        new_content += line
      end
    end

    # ensure any closed by EOF paragraphs are captured
    new_content += convert_to_paragraph(collected_paragraph) if collected_paragraph.size > 0
    new_content
  end

  private

  def self.convert_to_paragraph(collected_paragraph)
    combined_content_without_trailing_newline = collected_paragraph.join.rstrip

    # ensure the newline is added back after the closing paragraph tag
    "<p>#{combined_content_without_trailing_newline}</p>\n"
  end

  def self.collect?(line)
    return !paragraph_terminator?(line)
  end

  def self.is_new_line?(line)
    line === "\n"
  end

  def self.paragraph_terminator?(line)
    is_new_line?(line) || line.start_with?(HEADER_REGEX)
  end

  def self.can_close_paragraph?(line, collected_paragraph)
    paragraph_terminator?(line) && collected_paragraph.size > 0
  end
end