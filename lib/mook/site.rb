module Mook
  class Site
    def self.load(dir)
      pages = []
      for page_file in Dir.glob(File.join(dir, "pages", "*"))
        if MARKDOWN_EXTENSIONS.member?(File.extname(page_file).downcase)
          pages << Page.load(page_file)
        end
      end
      
      Site.new(pages.sort_by { |p| p.order })
    end
    
    attr_reader :pages

    def initialize(pages)
      @pages = pages
    end

    def render!
      renderer = Renderer.new(self)
      for page in @pages
        renderer.render!(page)
      end
    end

    def stage!
      FileUtils.mkdir_p("target")
      FileUtils.rm_rf(File.join("target", "*"))
      FileUtils.cp_r(Dir.glob(File.join("static", "*")), "target")
      for page in @pages
        File.open(File.join("target", "#{page.name}.html"), "w+") do |f|
          f << page.output
        end
      end
    end
  end
end