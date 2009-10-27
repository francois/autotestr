require "state_machine"

module Autotestr
  class Machine
    state_machine :initial => :unknown do
      event :success do
        transition :unknown => :green
        transition :red => :green
      end

      event :failed do
        transition :unknown => :red
        transition :green => :red
      end
    end
  end
end
