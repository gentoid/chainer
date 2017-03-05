# frozen_string_literal: true

RSpec.describe ::Chainer::Class do

  subject(:initialized) { described_class.new value }
  let(:value) { 0 }
  let(:to_s) { ->(x) { x.to_s } }
  let(:add1) { ->(x) { x + 1 } }

  it 'is frozen' do
    expect(initialized).to be_frozen
  end

  describe '#initialize' do

    it "doesn't wrap already wrapped object" do
      expect(described_class.new(initialized).value).to eq value
    end

  end

  describe '#>>' do

    it 'returns an instance of the class' do
      expect(initialized >> to_s).to be_a described_class
    end

    it 'calls passed object' do
      expect(to_s).to receive :call
      initialized >> to_s
    end

    it 'allows to chain calls further' do
      expect((initialized >> add1 >> to_s).value).to eq '1'
    end

  end

  describe '#value' do

    it 'returns the value it was initialized with' do
      expect(initialized.value).to eq value
    end

  end
end
