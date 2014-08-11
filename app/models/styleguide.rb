require 'forwardable'
require 'kss/parser'

class Styleguide
  extend Forwardable

  def_delegator :@parser, :sections

  def initialize
    paths = [Rails.root.join('app/assets/stylesheets'),
             Rails.root.join('vendor/assets/bower_components/dough/assets/stylesheets')]

    @parser = Kss::Parser.new(*paths)
  end
end
