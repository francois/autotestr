require "state_machine"

module Autotestr
  class Machine
    attr_accessor :changed_file

    state_machine :initial => :unknown do
      event :success do
        transition :unknown => :green
        transition :red => :green
      end

      event :failed do
        transition :unknown => :red
        transition :green => :red
      end

      event :file_changed do
        transition any => :tainted
      end

      after_transition :to => :tainted, :do => :log_changed_file

      state :unknown do
        def files_to_test
          Dir["test/**/*_test.rb"]
        end
      end

      state :tainted do
        attr_reader :files_to_test
      end
    end

    def initialize
      super
      @files_to_test = []
    end

    def changed!(file)
      self.changed_file = file
      file_changed
    end

    def log_changed_file
      files_to_test << changed_file
      self.changed_file = nil
    end
  end
end
