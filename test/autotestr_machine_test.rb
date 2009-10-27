require 'test_helper'

class MachineTest < Given::TestCase
  Given :a_new_machine do
    Then { expect(@machine.state) == "unknown" }

    When { @machine.success }
    Then { expect(@machine.state) == "green" }

    When { @machine.failed }
    Then { expect(@machine.state) == "red" }
  end

  Given :a_red_machine do
    Then { @machine.red? }

    When { @machine.success }
    Then { expect(@machine.green?) }
  end

  Given :a_green_machine do
    Then { expect(@machine.green?) }

    When { @machine.failed }
    Then { expect(@machine.red?) }
  end

  Given :a_green_machine do
    When { @machine.changed!("test/models/machine_test.rb") }
    Then { expect(@machine.tainted?) }
    Then { expect(@machine.changed_file.nil?) }
    Then { expect(@machine.files_to_test) == ["test/models/machine_test.rb"] }
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
