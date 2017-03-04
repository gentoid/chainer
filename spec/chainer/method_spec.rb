# frozen_string_literal: true

RSpec.describe ::Chainer::Method do

  # Priveds context class for the examples
  class Context

    def add1(arg)
      arg + 1
    end

    def add2(arg)
      arg + 2
    end

    private

    def private_add3(arg)
      arg + 3
    end

  end

  subject(:with_context) { described_class.new exec_context, value }
  let(:exec_context) { Context.new }
  let(:value) { 0 }

  it 'is frozen' do
    expect(with_context).to be_frozen
  end

  describe '#initialize' do

    context 'with already wrapped value' do
      subject(:with_pipe_as_value) { described_class.new exec_context, other_pipe }
      let(:other_pipe) { described_class.new Context.new, value }

      it "doesn't wrap already wrapped value" do
        expect(with_pipe_as_value.value).to eq value
      end

      it 'changes context of already wrapped value' do
        expect(with_pipe_as_value.context).to eq exec_context
      end
    end

  end

  describe '#>>' do

    it 'takes a symbol as the only parameter' do
      expect { with_context >> :add1 }.not_to raise_error
    end

    it 'returns an instance of the class' do
      expect(with_context >> :add1).to be_a described_class
    end

    it 'send the passed method name to the context with the value' do
      expect(exec_context).to have_received(:add1)
      with_context >> :add1
    end

    it 'allows to chain method calls further' do
      expect((with_context >> :add1 >> :add2).value).to eq 3
    end

    it 'calls private methods without problems' do
      expect((with_context >> :private_add3).value).to eq 3
    end

  end

  describe '#value' do

    it 'returns the value it was initialized with' do
      expect(with_context.value).to eq value
    end

  end
end
