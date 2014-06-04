module FixturesHelper
  def fixture(path)
    YAML.load_file('features/fixtures/' + path).to_ostruct
  end
end

World(FixturesHelper)
