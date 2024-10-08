require_relative "../app/header_converter.rb"

RSpec.describe HeaderConverter do
  describe "convert_headers" do
    it "converts a valid md header into an html header tag" do
      md = "## a header"
      expect(HeaderConverter.convert_headers(md)).to eq("<h2>a header</h2>")
    end

    (1..6).each do |size|
      it "supports headers size of #{size}" do
        md = "#{'#' * size} a header"
        expect(HeaderConverter.convert_headers(md)).to eq("<h#{size}>a header</h#{size}>")
      end
    end

    it "doesn't handle closing #'s" do
      md = "## a header ##"
      expect(HeaderConverter.convert_headers(md)).to eq("<h2>a header ##</h2>")
    end

    it "it doesn't matter if the header content is text or html (anchor tag)" do
      md = "## text <a href\"google.com\">Google</a> text"
      expect(HeaderConverter.convert_headers(md)).to eq("<h2>text <a href\"google.com\">Google</a> text</h2>")
    end

    it "must be the start of a line" do
      md = "some other content ## a header"
      expect(HeaderConverter.convert_headers(md)).to eq("some other content ## a header")
    end

    it "leading and trailing spaces, after the separating space, are removed" do
      md = "##      content       "
      expect(HeaderConverter.convert_headers(md)).to eq("<h2>content</h2>")
    end

    it "the entire line is the content" do
      md = "## this is a header\nthis is not"
      expect(HeaderConverter.convert_headers(md)).to eq("<h2>this is a header</h2>\nthis is not")
    end
  end
end
