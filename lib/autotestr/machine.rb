require "state_machine"

module Autotestr
  class Machine
    state_machine :initial => :unknown do
      event :success do
        transition :unknown => :green
      end
    end
  end
end
