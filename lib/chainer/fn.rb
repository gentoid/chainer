# frozen_string_literal: true

module Chainer
  class Fn

    def initialize(fn)
      @fn = fn
    end

    def fmap(other)
      wrap ->(*args) { other.(self.(*args)) }
    end

    def call(*args)
      fn.(*args)
    end

    private

    attr_reader :fn

    def wrap(value)
      self.class.new value
    end

  end
end
