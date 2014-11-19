Before do
  Warden.test_mode!
end

After do
  Warden.test_reset!
end

World(Warden::Test::Helpers)
