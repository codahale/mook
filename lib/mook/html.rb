module Mook
  # Renders Markdown as HTML, Pygmentizing any named code blocks and generating
  # TOC blocks.
  class HtmlRenderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
    
    def initialize(opts)
      super(opts)
      @toc = ""
      @toc_id = 0
      @toc_last_level = 0
      @toc_closed = false
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

      if @toc_last_level <= 0
        @toc << "<li>#{link}"
      else
        if @toc_last_level == header_level
          @toc << "</li><li>#{link}"
        elsif @toc_last_level < header_level
          @toc << "<ul><li>#{link}"
        else
          @toc << "</ul><li>#{link}"
        end
      end

      @toc_last_level = header_level

      "<a name=\"#{id}\"></a><h#{header_level}>#{text}</h#{header_level}>"
    end

    def toc
      unless @toc_closed
        @toc = "<ul>#{@toc}</li></ul>"
        @toc_closed = true
      end
      @toc
    end
  end
end