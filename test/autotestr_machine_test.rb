require 'test_helper'

class MachineTest < Given::TestCase
  Given :a_new_machine do
    Then { @machine.state == "unknown" }
  end

  protected

  def a_new_machine
    @machine = Autotestr::Machine.new
  end
end
