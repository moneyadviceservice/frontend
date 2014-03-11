class SearchResultDecorator < Draper::Decorator
  delegate :title, :description
end
