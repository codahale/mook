module Mook
  class Renderer
    MARKDOWN_OPTIONS = {
      :strikethrough => true,
      :fenced_code_blocks => true,
      :space_after_headers => true,
      :superscript => true,
      :autolink => true
    }
    HTML_OPTIONS = {

    }

    def initialize(site)
      @site = site
    end

    def render!(page)
      renderer = HtmlRenderer.new(HTML_OPTIONS)
      md = Redcarpet::Markdown.new(renderer, MARKDOWN_OPTIONS)

      page.content = md.render(page.markdown)
      page.toc = md.render(renderer.toc)

      template = ERB.new(File.read(File.join("templates", page.template)))
      model = Model.new(@site, page)
      page.output = renderer.postprocess(template.result(model.binding))
    end
  end
end