require 'test_helper'

class MachineTest < Given::TestCase
  Given :a_new_machine do
    Then { expect(@machine.state) == "unknown" }
    Then { expect(@machine.files_to_test.sort) == Dir["test/**/*_test.rb"].sort }
  end

  Given :a_green_machine do
    When { @machine.changed!("test/models/machine_test.rb") }
    Then { expect(@machine.tainted?) }
    Then { expect(@machine.changed_file.nil?) }
    Then { expect(@machine.files_to_test) == ["test/models/machine_test.rb"] }

    When do
      @machine.changed!("test/models/machine_test.rb")
      @machine.changed!("app/models/machine.rb")
    end
    Then { expect(@machine.tainted?) }
    Then { expect(@machine.changed_file.nil?) }
    Then { expect(@machine.files_to_test.length) == 2 }
    Then { expect(@machine.files_to_test) == ["test/models/machine_test.rb", "app/models/machine.rb"] }
  end

  Given :a_green_machine do
    When do
      @machine.changed!("test/models/machine_test.rb")
      @machine.run!
    end

    Then { expect(@test_files) == ["test/models/machine_test.rb"] }
  end

  Given :a_running_machine do
    When { @machine.success! }
    Then { expect(@machine.green?) }

    When { @machine.failed! }
    Then { expect(@machine.red?) }
  end

  protected

  def a_new_machine
    @machine = Autotestr::Machine.new do |files|
      @test_files = files.dup
    end
  end

  def a_running_machine
    a_new_machine
    @machine.run!
  end

  def a_red_machine
    a_running_machine
    @machine.failed!
  end

  def a_green_machine
    a_running_machine
    @machine.success!
  end
end
