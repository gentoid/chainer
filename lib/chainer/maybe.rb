# frozen_string_literal: true

module Chainer
  module Maybe

    module InstanceMethods
      def fmap(_)
        self
      end
    end

    def self.Just(value)
      Just.new value
    end

    def self.Nothing(*_)
      Nothing.new
    end

    def self.included(base)
      base.class_eval { attr_reader :value }
      base.include InstanceMethods
    end

    class Just
      include ::Chainer::Maybe

      def initialize(value)
        @value = value
      end

      def fmap(fn)
        fn.(value)
      end

    end

    class Nothing
      include ::Chainer::Maybe
    end

  end
end
