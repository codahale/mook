class Page
  METADATA = %w{ title template order }
  
  def self.load(filename)
    lines = File.read(filename)
    m, markdown = lines.split("* * *\n", 2)
    metadata = Hash[*m.split("\n").map { |s| s.split(": ", 2) }.map { |k, v| [k.downcase, v] }.flatten]
    
    raise "#{filename} has no title" unless metadata["title"]
    raise "#{filename} has no template" unless metadata["template"]
    
    order = (metadata["order"] || 1000).to_i
    
    Page.new(File.basename(filename), metadata["title"],
             metadata["template"], order,
             markdown.strip)
  end
  
  attr_reader :name, :title, :template, :order, :markdown
  attr_accessor :content, :output, :toc
  
  def initialize(name, title, template, order, markdown)
    @name = name.gsub(/\.[^\.]+$/, "")
    @title = title
    @template = template
    @order = order
    @markdown = markdown
  end
  
  def url
    "#{@name}.html"
  end
end