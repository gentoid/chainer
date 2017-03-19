# frozen_string_literal: true

module Chainer
  module Mixins
    def Chainer(value)
      Chainer::Method.new self, value
    end
  end
end
