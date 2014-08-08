require 'forwardable'
require 'kss/parser'

class Styleguide
  extend Forwardable

  def_delegator :@parser, :sections

  def initialize
    paths = [Rails.root.join('app/assets/stylesheets'),
             "#{Bundler.rubygems.find_name('dough-ruby').first.full_gem_path}/app/assets/stylesheets/dough"]

    @parser = Kss::Parser.new(*paths)
  end
end
