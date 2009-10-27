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

      event :test_changed do
        transition any => :tainted
      end

      before_transition :to => :tainted, :do => :reset_files_to_test
      after_transition  :to => :tainted, :do => :log_changed_file

      state :tainted do
        attr_reader :files_to_test
      end
    end

    def changed!(file)
      self.changed_file = file

      case file
      when /test/
        test_changed
      else
        raise ArgumentError, "Don't know how to handle changed file #{file.inspect}"
      end
    end

    def reset_files_to_test
      @files_to_test = []
    end

    def log_changed_file
      files_to_test << changed_file
      self.changed_file = nil
    end
  end
end
