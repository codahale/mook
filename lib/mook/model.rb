module Mook
  class Model
    def initialize(site, page)
      @site = site
      @page = page
    end

    def binding
      super
    end

  protected

    attr_reader :site, :page
    
    def partial(name)
      partial = ERB.new(File.read(File.join("templates", "_#{name}.erb")))
      partial.result(self.binding)
    end
  end
end