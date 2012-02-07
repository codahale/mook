module Mook
  # Renders Markdown as HTML, Pygmentizing any named code blocks and generating
  # TOC blocks.
  class HtmlRenderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
    
    def initialize(opts)
      super(opts)
      @toc_id = 0
      @toc = []
    end

    def block_code(code, language)
      if language
        Pygments.highlight(code, :lexer => language, :options => {:encoding => 'utf-8'})
      else
        "<pre>#{code}</pre>"
      end
    end

    def header(text, header_level)
      tag = if text =~ / #(.+)$/ then
        text = text.gsub(/ #(.+)$/, "")
        $1
      else
        nil
      end

      @toc_id += 1

      id = if tag then tag else "toc_#{@toc_id}" end

      link = "<a href=\"##{id}\">#{text}</a>"
      
      @toc << "#{"  " * (header_level - 1)}* #{link}"

      "<a name=\"#{id}\"></a><h#{header_level}>#{text}</h#{header_level}>"
    end

    def toc
      @toc.join("\n")
    end
  end
end