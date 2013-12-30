require 'forwardable'
require 'kss/parser'
require 'singleton'

class Styleguide::Definition
  extend Forwardable
  include Singleton

  def_delegator :@parser, :sections

  def initialize(stylesheets_path: Rails.root.join('app/assets/stylesheets'))
    @parser = Kss::Parser.new(stylesheets_path)
  end
end
