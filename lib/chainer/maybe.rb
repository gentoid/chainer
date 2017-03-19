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
        return applicative_list(apply) if iterative?(apply)
        applicative(apply)
      end

      def maybe?
        true
      end

      def applicative_list(list)
        list.reduce([]) do |memo, apply|
          memo + Array(applicative(apply))
        end
      end

      def applicative(apply)
        return apply unless apply.maybe?
        wrap value.(apply.value)
      end

      def iterative?(value)
        value.is_a?(::Chainer::List) || value.is_a?(Array)
      end

      def wrap(value)
        self.class.new value
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
