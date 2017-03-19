# frozen_string_literal: true

module Chainer
  class List

    def initialize(list)
      @list = list
    end

    def fmap(fn)
      wrap list.map { |item| fn.(item) }
    end

    attr_reader :list

    def wrap(value)
      self.class.new value
    end

  end
end
