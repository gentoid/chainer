module Chainer
  class Matcher

    attr_reader :match

    def initialize(match_on, variants, &block)
      @class_name = match_on.class.name.split('::').last.to_sym
      @variants = variants
      @block = block
    end

    def call
      instance_eval &@block
      self
    end

    def method_missing(method_name, *args, &match_block)
      return super unless @variants.include? method_name
      return unless method_name == @class_name

      @match = match_block
    end

  end
end
