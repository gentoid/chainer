# frozen_string_literal: true

module Chainer
  # Pipes objects with +call+ method
  class Class

    # @!attribute [r]   value
    #   @return   [Object]        Wrapped value
    attr_reader :value

    # Initializes pipe wrapper
    #
    # @param    [Object, #call]     value     Value to be wrapped and sent to the next in the pipe
    def initialize(value)
      @value = value.is_a?(self.class) ? value.value : value
      freeze
    end

    # @fn       def >> object
    # @brief    The "pipe" operator. Calls passed +object+ with the wrapped +value+
    #
    # @param    [#call]   object    Next object in the pipe which going to be called
    #
    # @return   [self]              Wrapped result of calculations
    def >>(object) # rubocop:disable Style/OpMethod
      self.class.new object.(value)
    end

  end
end
