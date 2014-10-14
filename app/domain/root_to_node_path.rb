class RootToNodePath
  def self.build(category, category_tree)
    node = category_tree.find { |n| n.name == category.id }
    if node
      node.parentage.reverse.map(&:content) + [category]
    else
      []
    end
  end
end
