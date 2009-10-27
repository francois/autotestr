require "rubygems"
require "test/unit"
require "given/test_unit"

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

gem "pluginaweek-state_machine"
require "autotestr"

begin
  require "ruby-debug"
rescue LoadError
  # NOP: ignore
end

class Test::Unit::TestCase
end
