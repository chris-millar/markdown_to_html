require 'optparse'
require_relative 'app/markdown_converter.rb'

DEFAULT_FILE_PATH = "input.md"
DEFAULT_OPEN_BROWSER = false
DEFAULT_SILENT = false

# define a simple data structure for the command line arguments
Options = Struct.new(:file_path, :open_browser, :silent)

# set defaults, command line arguments can override them
@options = Options.new(DEFAULT_FILE_PATH, DEFAULT_OPEN_BROWSER, DEFAULT_SILENT)

OptionParser.new do |opts|
  opts.on("-fFILE_PATH", "--file_path=FILE_PATH", "Provide the path to a markdown file to convert to html, defaults to 'input.md'") do |file_path|
    @options.file_path = file_path
  end

  opts.on("-o", "--open_browser", "Open the output.html in Chrome") do
    @options.open_browser = true
  end

  opts.on("-s", "--silent", "Don't print the converted HTML to stdout") do
    @options.silent = true
  end
end.parse!

input_markdown_file_path = @options.file_path
if File.file?(input_markdown_file_path)
  # read the markdown content
  markdown_file = File.read(input_markdown_file_path)

  # convert the markdown to html
  converted_html = MarkdownConverter.to_html(markdown_file)

  # write to the output.html file in this directory
  output_file = File.new("output.html", "w")
  output_file << converted_html
  output_file.close

  # optionally, open the html in Chrome
  system "open", "-a", "Google Chrome", "output.html" if @options.open_browser

  # optionally, print the html to stdout
  puts converted_html unless @options.silent
else
  # handle if the provided markdown file path doesn't exist
  puts "No File found at path #{input_markdown_file_path}"
end