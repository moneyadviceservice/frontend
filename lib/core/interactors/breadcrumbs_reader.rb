class Core::BreadcrumbsReader
  def call(&block)
    block.call if block_given?
  end
end
