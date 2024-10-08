require_relative "../app/markdown_converter"

RSpec.describe MarkdownConverter do
  describe "to_html" do
    it "provided example 1" do
      md = File.read("./spec/examples/example_one.md")
      expect(MarkdownConverter.to_html(md)).to eq(
'''# Sample Document

Hello!

This is sample markdown for the <a href="https://www.mailchimp.com">Mailchimp</a> homework assignment.'''
      )
    end

    it "provided example 2" do
      md = File.read("./spec/examples/example_two.md")
      expect(MarkdownConverter.to_html(md)).to eq(
        '''# Header one

Hello there

How are you?
What\'s going on?

## Another Header

This is a paragraph <a href="http://google.com">with an inline link</a>. Neat, eh?

## This is a header <a href="http://yahoo.com">with a link</a>'''
      )
    end
  end
end
