# frozen_string_literal: true

require 'pueri'

RSpec.describe Pueri do
  it 'has a version number' do
    expect(Pueri.version).not_to be nil
    expect(Pueri.version).to be_a String
  end
end

RSpec.describe Pueri::Age do
  context 'when creation follows documentation' do
    let(:example1) { Pueri::Age.new('080690') }
    let(:example2) { Pueri::Age.new('08/06/15') }
    let(:example3) { Pueri::Age.new('08061990') }
    let(:example4) do
      require 'date'
      day = Date.today.day + 1
      day = 30 if Date.today.day > 30
      month = Date.today.month + 1
      month = 12 if Date.today.month == 12
      Pueri::Age.new("#{day}/#{month}/1945")
    end

    it 'calculates ages' do
      expect(example1).not_to be nil
      expect(example1).to be_a Pueri::Age
      expect(example1.to_f).not_to be nil
      expect(example1.to_f).not_to be 0.0
      expect(example1.to_f).to be_a Float

      expect(example2).not_to be nil
      expect(example2).to be_a Pueri::Age
      expect(example2.to_f).not_to be nil
      expect(example2.to_f).not_to be 0.0
      expect(example2.to_f).to be_a Float

      expect(example3).not_to be nil
      expect(example3).to be_a Pueri::Age
      expect(example3.to_f).not_to be nil
      expect(example3.to_f).not_to be 0.0
      expect(example3.to_f).to be_a Float

      expect(example4).not_to be nil
      expect(example4).to be_a Pueri::Age
      expect(example4.to_f).not_to be nil
      expect(example4.to_f).not_to be 0.0
      expect(example4.to_f).to be_a Float
    end

    it 'outputs short-format age strings' do
      expect(example1.to_s(true)).not_to be nil
      expect(example1.to_s(true)).to be_a String

      expect(example2.to_s(true)).not_to be nil
      expect(example2.to_s(true)).to be_a String

      expect(example3.to_s(true)).not_to be nil
      expect(example3.to_s(true)).to be_a String

      expect(example4.to_s(true)).not_to be nil
      expect(example4.to_s(true)).to be_a String
    end

    it 'outputs long-format age strings' do
      expect(example1.to_s).not_to be nil
      expect(example1.to_s).to be_a String

      expect(example2.to_s).not_to be nil
      expect(example2.to_s).to be_a String

      expect(example3.to_s).not_to be nil
      expect(example3.to_s).to be_a String

      expect(example4.to_s).not_to be nil
      expect(example4.to_s).to be_a String
    end

    it 'outputs ages in days' do
      expect(example1.to_f).not_to be nil
      expect(example1.to_f).to be_a Float
      expect(example1.to_f).to be > 0.0

      expect(example2.to_f).not_to be nil
      expect(example2.to_f).to be_a Float
      expect(example2.to_f).to be > 0.0

      expect(example3.to_f).not_to be nil
      expect(example3.to_f).to be_a Float
      expect(example3.to_f).to be > 0.0

      expect(example4.to_f).not_to be nil
      expect(example4.to_f).to be_a Float
      expect(example4.to_f).to be > 0.0
    end
  end

  context 'when creation ignores documentation' do
    let(:example) { Pueri::Age.new('08065090') }

    it 'ignores dates on the future' do
      expect(example).not_to be nil
      expect(example.to_f).to be_a Float
      expect(example.to_f).to be 0.0
    end
  end
end
