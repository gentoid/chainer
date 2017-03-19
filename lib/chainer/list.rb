# frozen_string_literal: true

module Chainer
  class List

    def initialize(list)
      @list = list
    end

    def fmap(fn)
      wrap list.map { |item| fn.(item) }
    end

    def *(value)
      iterative?(value) ? applicative_list(value) : applicative(value)
    end

    attr_reader :list

    def wrap(value)
      self.class.new value
    end

    def applicative_list(other_list)
      other_list.reduce([]) do |memo, value|
        memo + applicative(value)
      end
    end

    def applicative(value)
      list.map do |maybe_fn|
        next maybe_fn unless maybe_fn.maybe? && value.maybe?

        wrap maybe_fn.value.(value.value)
      end
    end

    def iterative?(value)
      value.is_a?(self.class) || value.is_a?(Array)
    end

  end
end
