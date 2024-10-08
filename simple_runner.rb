require_relative 'app/markdown_converter.rb'

FILE_PATH = "input.md"

input = File.file?(FILE_PATH) ? File.read(FILE_PATH) : "Add an #{FILE_PATH} to the root directory and run again"

puts MarkdownConverter.to_html(input)