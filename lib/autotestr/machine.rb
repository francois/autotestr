require "state_machine"

module Autotestr
  class Machine
    attr_accessor :changed_file

    state_machine :initial => :unknown do
      event :success do
        transition :running => :green
      end

      event :failed do
        transition :running => :red
      end

      event :file_changed do
        transition any => :tainted
      end

      event :run do
        transition [:unknown, :tainted] => :running
      end

      after_transition  :to => :tainted, :do => :log_changed_file
      before_transition :to => :running, :do => :launch_runner

      state :unknown do
        def files_to_test
          Dir["test/**/*_test.rb"]
        end
      end

      state :tainted do
        attr_reader :files_to_test
      end
    end

    def initialize(&run_block)
      super
      @files_to_test = []
      @run_block = run_block
    end

    def changed!(file)
      self.changed_file = file
      file_changed
    end

    def log_changed_file
      files_to_test << changed_file
      self.changed_file = nil
    end

    def launch_runner
      @run_block.call(files_to_test)
    end
  end
end
