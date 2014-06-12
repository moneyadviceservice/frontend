class RootToNodePath
  def self.build(category, category_tree)
    if node = category_tree.find { |n| n.name == category.id }
      node.parentage.reverse.collect(&:content) + [category]
    else
      []
    end
  end
end
