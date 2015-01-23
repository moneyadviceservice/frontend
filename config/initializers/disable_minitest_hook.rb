# Minitest hijacks the exit code set by cucumber.
# Minitest.autorun sets up a series of at_exit hooks that
# interfere with it.

# In certain circumstances, this will make `rake cucumber`
# exit with 0 every time, making our build pass erroneously.

# Since we don't use minitest in any capacity and it seems
# to only be here to make life interesting - we're going to
# patch it out.

if defined? Minitest
  Minitest.module_eval do
    def self.autorun; end
  end
end
