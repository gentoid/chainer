# frozen_string_literal: true

# Allows to pipe Ruby calls in a nice way
module Chainer
  autoload :Class, 'chainer/class'
  autoload :Fn, 'chainer/fn'
  autoload :List, 'chainer/list'
  autoload :Method, 'chainer/method'
  autoload :Mixins, 'chainer/mixins'
  autoload :VERSION, 'chainer/version'

  def self.included(base)
    base.include Mixins
  end
end
