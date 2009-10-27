require 'test_helper'

class MachineTest < Given::TestCase
  Given :a_new_machine do
    Then { @machine.state == "unknown" }

    When { @machine.success }
    Then { @machine.state == "green" }

    When { @machine.failed }
    Then { @machine.state == "red" }
  end

  Given :a_red_machine do
    Then { @machine.red? }

    When { @machine.success }
    Then { @machine.green? }
  end

  Given :a_green_machine do
    Then { @machine.green? }

    When { @machine.failed }
    Then { @machine.red? }
  end

  protected

  def a_new_machine
    @machine = Autotestr::Machine.new
  end

  def a_red_machine
    a_new_machine
    @machine.failed
  end

  def a_green_machine
    a_new_machine
    @machine.success
  end
end
