# frozen_string_literal: true

require 'singleton'

module Chainer
  module Maybe

    def self.Just(value)
      Just.new value
    end

    def self.Nothing(*_)
      Nothing.instance
    end

    def self.included(base)
      base.class_eval { attr_reader :value }
    end

    class Just
      include ::Chainer::Maybe

      def initialize(value)
        @value = value
      end

      def fmap(fn)
        fn.(value)
      end

      def *(apply)
        apply.maybe? ? @value.(apply.value) : apply
      end

      def maybe?
        true
      end

    end

    class Nothing
      include Singleton
      include ::Chainer::Maybe

      def fmap(_)
        self
      end

      def *(_)
        self
      end

      def maybe?
        false
      end
    end

  end
end
