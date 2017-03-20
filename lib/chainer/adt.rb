module Chainer
  class ADT

    attr_reader :context, :block

    def self.define(context, &block)
      new(context, &block).()
    end

    def initialize(context, &block)
      @context = context
      @block = block
      freeze
    end

    def call
      instance_eval &block
    end

    def method_missing(method_name, *args)
      init_block = get_block_with_arity(args)

      class_definition = ::Class.new(context) do
        attr_reader :value

        define_method :initialize, init_block

        def make_hash_for(args, *values)
          args.zip(values)
          .each_with_object({}) do |(arg, value), memo|
            memo[arg] = value
          end
        end

      end

      context.const_set method_name, class_definition

      context.define_singleton_method(method_name) { |*args| const_get(method_name).new *args }
    end

    def get_block_with_arity(args)
      method_names = [
        :zero_args,
        :one_arg,
        :two_args,
        :three_args,
        :four_args,
        :five_args,
        :six_args,
        :seven_args,
        :eight_args,
        :nine_args,
      ]

      send method_names[args.count], args
    end

    def zero_args(_)
      ->() {}
    end

    def one_arg(args)
      ->(arg) { @value = arg }
    end

    def two_args(args)
      ->(one, two) { @value = make_hash_for(args, one, two) }
    end

    def three_args(args)
      ->(one, two, three) { @value = make_hash_for(args, one, two, three) }
    end

  end
end
