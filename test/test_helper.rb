require "rubygems"
require "test/unit"
require "given/test_unit"

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

gem "pluginaweek-state_machine"
require "autotestr"

class Test::Unit::TestCase
end
