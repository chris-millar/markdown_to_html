require_relative "../app/paragraph_converter.rb"

RSpec.describe ParagraphConverter do
  describe "convert_paragraphs" do
    it "converts content into a paragraph tag" do
      md = "some content\n"
      expect(ParagraphConverter.convert_paragraphs(md)).to eq("<p>some content</p>\n")
    end

    describe "collects" do
      it "doesn't collect header lines into paragraphs" do
        md = "some content\n<h1>header</h1>\nmore content\n"
        expect(ParagraphConverter.convert_paragraphs(md)).to eq("<p>some content</p>\n<h1>header</h1>\n<p>more content</p>\n")
      end

      it "doesn't collect blank lines into paragraphs, but still preserves them" do
        md = "some content\n\nmore content\n"
        expect(ParagraphConverter.convert_paragraphs(md)).to eq("<p>some content</p>\n\n<p>more content</p>\n")
      end

      it "any other content, even across multiple lines" do
        md = "some content\n\nmore content\nacross lines"
        expect(ParagraphConverter.convert_paragraphs(md)).to eq("<p>some content</p>\n\n<p>more content\nacross lines</p>\n")
      end

      it "collects any html, including existing paragraph tags" do
        md = "<div>some content</div>\n\n<p>more content</p>\n"
        expect(ParagraphConverter.convert_paragraphs(md)).to eq("<p><div>some content</div></p>\n\n<p><p>more content</p></p>\n")
      end

      it "links can be inside paragraphs" do
        md = "some content <a href=\"google.com\">google</a> with a link in the middle\n"
        expect(ParagraphConverter.convert_paragraphs(md)).to eq("<p>some content <a href=\"google.com\">google</a> with a link in the middle</p>\n")
      end
    end

    it "closes a paragraph even when at the beginning and end of the content" do
      md = "some content\n<h1>header</h1>\nmore content"
      expect(ParagraphConverter.convert_paragraphs(md)).to eq("<p>some content</p>\n<h1>header</h1>\n<p>more content</p>\n")
    end

    it "moves the final \n of a paragraphs content to after the closing paragraph tag" do
      md = "some content\n"
      expect(ParagraphConverter.convert_paragraphs(md)).to eq("<p>some content</p>\n")
    end
  end
end
