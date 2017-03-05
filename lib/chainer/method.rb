# frozen_string_literal: true

module Chainer
  # Pipes method names on a context class
  class Method

    # @!attribute [r]   context
    #   @return   [Object]        Context to call piped methods on
    # @!attribute [r]   value
    #   @return   [Object]        Value to pass to the next method in the pipe
    attr_reader :context, :value

    # Initializes pipe wrapper
    #
    # @param    [Object]     context    Context to call piped methods on
    # @param    [Object]     value      Value to pass to the next method in the pipe
    def initialize(context, value)
      @context = context
      @value = value.is_a?(self.class) ? value.value : value
      freeze
    end

    # The "pipe" operator. Calls passed +object+ with the wrapped +value+
    #
    # @param    [Symbol]    method_name     Method name to be called on the context +object+
    #
    # @return   [self]                      Wrapped result of calculations
    def >>(method_name) # rubocop:disable Style/OpMethod
      self.class.new context, context.send(method_name, value)
    end

  end
end
