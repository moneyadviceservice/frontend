# require 'sass-rails'

# module Sass::Script::Functions
#   def development_environment()
#     Sass::Script::Bool.new(environment == :development)
#   end

#   declare :development_environment, :args => []
# end

# sass_options = {:custom => { :development_environment => {} } }

module Sass::Script::Functions
  def custom_env(value)
    rgb = options[:custom][:custom_env][value.to_s].scan(/^#?(..?)(..?)(..?)$/).first.map {|a| a.ljust(2, a).to_i(16)}
    Sass::Script::Color.new(rgb)
  end

  def reverse(string)
    assert_type string, :String
    Sass::Script::String.new(string.value.reverse)
  end
  declare :reverse, :args => [:string]
end

sass_options = {:custom => { :custom_env => {"main" => "#ff1122"} } }