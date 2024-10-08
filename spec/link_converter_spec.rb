require_relative "../app/link_converter.rb"

RSpec.describe LinkConverter do
  describe "convert_links" do
    it "converts a valid md link to an anchor tag" do
      md = "[My Link](https://google.com)"
      expect(LinkConverter.convert_links(md)).to eq("<a href=\"https://google.com\">My Link</a>")
    end

    describe "it does not convert blank" do
      it "link_texts" do
        md = "[](https://google.com)"
        expect(LinkConverter.convert_links(md)).to eq("[](https://google.com)")
      end

      it "urls" do
        md = "[some link]()"
        expect(LinkConverter.convert_links(md)).to eq("[some link]()")
      end
    end

    describe "doesn't touch non link content" do
      it "for just text" do
        md = "Other content that is not touched [My Link](https://google.com) even when the link is in the middle"
        expect(LinkConverter.convert_links(md)).to eq("Other content that is not touched <a href=\"https://google.com\">My Link</a> even when the link is in the middle")
      end

      it "for headers" do
        md = "## Some Text [My Link](https://google.com) around link"
        expect(LinkConverter.convert_links(md)).to eq("## Some Text <a href=\"https://google.com\">My Link</a> around link")
      end
    end

    it "converts all links in the input, wherever they are" do
      md = '''# Header link [Google](https://google.com)

        Some misc text
        wrapped on multilines

        within some text [Bing](https://bing.com) it works too'''

      expect(LinkConverter.convert_links(md)).to eq(
        '''# Header link <a href="https://google.com">Google</a>

        Some misc text
        wrapped on multilines

        within some text <a href="https://bing.com">Bing</a> it works too'''
      )
    end

    it "won't convert a link whose url's TLD is only 1 character long" do
      md = "[AI](https://a.i)"
      expect(LinkConverter.convert_links(md)).to eq("[AI](https://a.i)")
    end

    describe "checks the protocol" do
      it "only accepts http|s" do
        md = "[My Link](https://google.com)"
        expect(LinkConverter.convert_links(md)).to eq("<a href=\"https://google.com\">My Link</a>")

        md = "[My Link](http://google.com)"
        expect(LinkConverter.convert_links(md)).to eq("<a href=\"http://google.com\">My Link</a>")

        md = "[My Link](ftp://google.com)"
        expect(LinkConverter.convert_links(md)).to eq("[My Link](ftp://google.com)")
      end

      it "the protocol is optional" do
        md = "[protocol optional](google.com)"
        expect(LinkConverter.convert_links(md)).to eq("<a href=\"google.com\">protocol optional</a>")
      end

      it "is case insensitive" do
        md = "[Google](HTTP://google.com)"
        expect(LinkConverter.convert_links(md)).to eq("<a href=\"HTTP://google.com\">Google</a>")
      end
    end
  end
end
