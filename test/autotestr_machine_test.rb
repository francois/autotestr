require 'test_helper'

class MachineTest < Given::TestCase
  Given :a_new_machine do
    Then { @machine.state == "unknown" }

    When { @machine.success }
    Then { @machine.state == "green" }

    When { @machine.failed }
    Then { @machine.state == "red" }
  end

  protected

  def a_new_machine
    @machine = Autotestr::Machine.new
  end
end
