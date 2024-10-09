require_relative "../app/markdown_converter"

RSpec.describe MarkdownConverter do
  describe "to_html" do
    it "provided example 1" do
      md = File.read("./spec/examples/example_one.md")
      html = File.read("./spec/expected_html/example_one.html")
      expect(MarkdownConverter.to_html(md)).to eq(html)
    end

    it "provided example 2" do
      md = File.read("./spec/examples/example_two.md")
      html = File.read("./spec/expected_html/example_two.html")
      expect(MarkdownConverter.to_html(md)).to eq(html)
    end

    it "complex example" do
      md = File.read("./spec/examples/complex.md")
      html = File.read("./spec/expected_html/complex.html")
      expect(MarkdownConverter.to_html(md)).to eq(html)
    end
  end
end
