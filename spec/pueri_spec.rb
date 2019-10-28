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

RSpec.describe Pueri::Vax do
  context 'when creation follows documentation' do
    let(:example1) { Pueri::Vax.new(30.0) }
    let(:example2) { Pueri::Vax.new(70.0) }
    let(:example3) { Pueri::Vax.new(100.0) }
    let(:example4) { Pueri::Vax.new(130.0) }
    let(:example5) { Pueri::Vax.new(160.0) }
    let(:example6) { Pueri::Vax.new(190.0) }
    let(:example7) { Pueri::Vax.new(280.0) }
    let(:example8) { Pueri::Vax.new(370.0) }
    let(:example9) { Pueri::Vax.new(460.0) }
    let(:example10) { Pueri::Vax.new(1500.0) }
    let(:example11) { Pueri::Vax.new(4000.0) }

    it 'parses ages in days' do
      expect(example1).not_to be nil
      expect(example2).not_to be nil
      expect(example3).not_to be nil
      expect(example4).not_to be nil
      expect(example5).not_to be nil
      expect(example6).not_to be nil
      expect(example7).not_to be nil
      expect(example8).not_to be nil
      expect(example9).not_to be nil
      expect(example10).not_to be nil
      expect(example11).not_to be nil

      expect(example1).to be_a Pueri::Vax
      expect(example2).to be_a Pueri::Vax
      expect(example3).to be_a Pueri::Vax
      expect(example4).to be_a Pueri::Vax
      expect(example5).to be_a Pueri::Vax
      expect(example6).to be_a Pueri::Vax
      expect(example7).to be_a Pueri::Vax
      expect(example8).to be_a Pueri::Vax
      expect(example9).to be_a Pueri::Vax
      expect(example10).to be_a Pueri::Vax
      expect(example11).to be_a Pueri::Vax
    end

    it 'outputs the adequate vaccine calendar for the age' do
      expect(example1.table).not_to be nil
      expect(example2.table).not_to be nil
      expect(example3.table).not_to be nil
      expect(example4.table).not_to be nil
      expect(example5.table).not_to be nil
      expect(example6.table).not_to be nil
      expect(example7.table).not_to be nil
      expect(example8.table).not_to be nil
      expect(example9.table).not_to be nil
      expect(example10.table).not_to be nil
      expect(example11.table).not_to be nil

      expect(example1.table).to be_a String
      expect(example2.table).to be_a String
      expect(example3.table).to be_a String
      expect(example4.table).to be_a String
      expect(example5.table).to be_a String
      expect(example6.table).to be_a String
      expect(example7.table).to be_a String
      expect(example8.table).to be_a String
      expect(example9.table).to be_a String
      expect(example10.table).to be_a String
      expect(example11.table).to be_a String
    end

    it 'outputs the table notes' do
      expect(example1.parse_notes).not_to be nil
      expect(example1.parse_notes).to be_a String
    end
  end

  context 'when creation ignores documentation' do
    let(:example1) { Pueri::Vax.new(0.0) }
    let(:example2) { Pueri::Vax.new(60_000.0) }

    it 'raises an error when age is out of range' do
      expect { example1 }.to raise_error ArgumentError
      expect { example2 }.to raise_error ArgumentError
    end
  end
end

RSpec.describe Pueri::Neuro do
  context 'when creation follows documentation' do
    let(:example1) { Pueri::Neuro.new(10.0) }
    let(:example2) { Pueri::Neuro.new(70.0) }
    let(:example3) { Pueri::Neuro.new(100.0) }
    let(:example4) { Pueri::Neuro.new(130.0) }
    let(:example5) { Pueri::Neuro.new(190.0) }
    let(:example6) { Pueri::Neuro.new(280.0) }
    let(:example7) { Pueri::Neuro.new(310.0) }
    let(:example8) { Pueri::Neuro.new(370.0) }
    let(:example9) { Pueri::Neuro.new(460.0) }
    let(:example10) { Pueri::Neuro.new(550.0) }
    let(:example11) { Pueri::Neuro.new(740.0) }
    let(:example12) { Pueri::Neuro.new(1_100.0) }

    it 'parses ages in days' do
      expect(example1).not_to be nil
      expect(example2).not_to be nil
      expect(example3).not_to be nil
      expect(example4).not_to be nil
      expect(example5).not_to be nil
      expect(example6).not_to be nil
      expect(example7).not_to be nil
      expect(example8).not_to be nil
      expect(example9).not_to be nil
      expect(example10).not_to be nil
      expect(example11).not_to be nil
      expect(example12).not_to be nil

      expect(example1).to be_a Pueri::Neuro
      expect(example2).to be_a Pueri::Neuro
      expect(example3).to be_a Pueri::Neuro
      expect(example4).to be_a Pueri::Neuro
      expect(example5).to be_a Pueri::Neuro
      expect(example6).to be_a Pueri::Neuro
      expect(example7).to be_a Pueri::Neuro
      expect(example8).to be_a Pueri::Neuro
      expect(example9).to be_a Pueri::Neuro
      expect(example10).to be_a Pueri::Neuro
      expect(example11).to be_a Pueri::Neuro
      expect(example12).to be_a Pueri::Neuro
    end

    it 'outputs neuropsichosocial development tables' do
      expect(example1.table).not_to be nil
      expect(example2.table).not_to be nil
      expect(example3.table).not_to be nil
      expect(example4.table).not_to be nil
      expect(example5.table).not_to be nil
      expect(example6.table).not_to be nil
      expect(example7.table).not_to be nil
      expect(example8.table).not_to be nil
      expect(example9.table).not_to be nil
      expect(example10.table).not_to be nil
      expect(example11.table).not_to be nil
      expect(example12.table).not_to be nil

      expect(example1.table).to be_a String
      expect(example2.table).to be_a String
      expect(example3.table).to be_a String
      expect(example4.table).to be_a String
      expect(example5.table).to be_a String
      expect(example6.table).to be_a String
      expect(example7.table).to be_a String
      expect(example8.table).to be_a String
      expect(example9.table).to be_a String
      expect(example10.table).to be_a String
      expect(example11.table).to be_a String
      expect(example12.table).to be_a String
    end
  end

  context 'when creation ignores documentation' do
    let(:example1) { Pueri::Neuro.new(0.0) }
    let(:example2) { Pueri::Neuro.new(60_000.0) }

    it 'raises an error when age is out of range' do
      expect { example1 }.to raise_error ArgumentError
      expect { example2 }.to raise_error ArgumentError
    end
  end
end

RSpec.describe Pueri::DoseCalc do
  context 'when creation follows documentation' do
    let(:example1) do
      Pueri::DoseCalc.new(
        weight: 18,
        dose: 30,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mg/kg/d',
        conc_unit: 'mg/mL',
        name: '  Cefalexina   '
      )
    end
    let(:example2) do
      Pueri::DoseCalc.new(
        weight: 30,
        dose: 200,
        time: 24,
        days: 1,
        concentration: 6_000,
        dose_unit: 'mcg/kg/d',
        conc_unit: 'mcg/cp',
        name: 'Ivermectina'
      )
    end

    it 'calculates medications\' prescription doses' do
      expect(example1).not_to be nil
      expect(example1).to be_a Pueri::DoseCalc
      expect(example1.to_f).to eq 2.7

      expect(example2).not_to be nil
      expect(example2).to be_a Pueri::DoseCalc
      expect(example2.to_f).to eq 1.0
    end

    it 'outputs doses as a prescription string' do
      expect(example1.to_s).not_to be nil
      expect(example1.to_s).to be_a String
      expect(example1.to_s.size).to be > 0

      expect(example2.to_s).not_to be nil
      expect(example2.to_s).to be_a String
      expect(example2.to_s.size).to be > 0
    end

    it 'outputs doses for each taking as floats' do
      expect(example1.to_f).not_to be nil
      expect(example1.to_f).to be_a Float

      expect(example2.to_f).not_to be nil
      expect(example2.to_f).to be_a Float
    end
  end

  context 'when creation ignores documentation' do
    let(:example1) do
      Pueri::DoseCalc.new(
        weight: 0,
        dose: 30,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mg/kg/d',
        conc_unit: 'mg/mL',
        name: 'Cefalexina'
      )
    end
    let(:example2) do
      Pueri::DoseCalc.new(
        weight: 18,
        dose: 0,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mg/kg/d',
        conc_unit: 'mg/mL',
        name: 'Cefalexina'
      )
    end
    let(:example3) do
      Pueri::DoseCalc.new(
        weight: 18,
        dose: 30,
        time: 0,
        days: 7,
        concentration: 50,
        dose_unit: 'mg/kg/d',
        conc_unit: 'mg/mL',
        name: 'Cefalexina'
      )
    end
    let(:example4) do
      Pueri::DoseCalc.new(
        weight: 18,
        dose: 30,
        time: 6,
        days: 0,
        concentration: 50,
        dose_unit: 'mg/kg/d',
        conc_unit: 'mg/mL',
        name: 'Cefalexina'
      )
    end
    let(:example5) do
      Pueri::DoseCalc.new(
        weight: 18,
        dose: 30,
        time: 6,
        days: 7,
        concentration: 0,
        dose_unit: 'mg/kg/d',
        conc_unit: 'mg/mL',
        name: 'Cefalexina'
      )
    end
    let(:example6) do
      Pueri::DoseCalc.new(
        weight: 18,
        dose: 30,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: '',
        conc_unit: 'mg/mL',
        name: 'Cefalexina'
      )
    end
    let(:example7) do
      Pueri::DoseCalc.new(
        weight: 18,
        dose: 30,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mg/kg/d',
        conc_unit: '',
        name: 'Cefalexina'
      )
    end
    let(:example8) do
      Pueri::DoseCalc.new(
        weight: 18,
        dose: 30,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mg/kg/d',
        conc_unit: 'mg/mL',
        name: ''
      )
    end
    let(:example9) do
      Pueri::DoseCalc.new(
        weight: 18,
        dose: 30,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mg/kg',
        conc_unit: 'mg/mL',
        name: 'Cefalexina'
      )
    end
    let(:example10) do
      Pueri::DoseCalc.new(
        weight: 18,
        dose: 30,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mg/kg/d',
        conc_unit: 'mg',
        name: 'Cefalexina'
      )
    end

    it 'checks for parameter integrity and conformity' do
      expect { example1 }.to raise_error ArgumentError
      expect { example2 }.to raise_error ArgumentError
      expect { example3 }.to raise_error ArgumentError
      expect { example4 }.to raise_error ArgumentError
      expect { example5 }.to raise_error ArgumentError
      expect { example6 }.to raise_error ArgumentError
      expect { example7 }.to raise_error ArgumentError
      expect { example8 }.to raise_error ArgumentError
      expect { example9 }.to raise_error ArgumentError
      expect { example10 }.to raise_error ArgumentError
    end
  end
end

RSpec.describe Pueri::DoseCalc do
  context 'when creation follows documentation' do
    let(:example1) do
      Pueri::DoseCheck.new(
        weight: 18,
        dose: 2.7,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mL',
        conc_unit: 'mg/mL',
        name: 'Cefalexina',
        way: 'VO'
      )
    end
    let(:example2) do
      Pueri::DoseCheck.new(
        weight: 30,
        dose: 1,
        time: 24,
        days: 1,
        concentration: 6_000,
        dose_unit: 'cp',
        conc_unit: 'mcg/cp',
        name: 'Ivermectina',
        way: 'VO'
      )
    end

    it 'calculates medications\' prescription dosages' do
      expect(example1).not_to be nil
      expect(example1).to be_a Pueri::DoseCheck
      expect(example1.to_f).to eq 30.0

      expect(example2).not_to be nil
      expect(example2).to be_a Pueri::DoseCheck
      expect(example2.to_f).to eq 200.0
    end

    it 'outputs dosages as a string' do
      expect(example1.to_s).not_to be nil
      expect(example1.to_s).to be_a String
      expect(example1.to_s.size).to be > 0

      expect(example2.to_s).not_to be nil
      expect(example2.to_s).to be_a String
      expect(example2.to_s.size).to be > 0
    end

    it 'outputs dosages as a float' do
      expect(example1.to_f).not_to be nil
      expect(example1.to_f).to be_a Float

      expect(example2.to_f).not_to be nil
      expect(example2.to_f).to be_a Float
    end
  end

  context 'when creation follows documentation' do
    let(:example1) do
      Pueri::DoseCheck.new(
        weight: 0,
        dose: 2.7,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mL',
        conc_unit: 'mg/mL',
        name: 'Cefalexina',
        way: 'VO'
      )
    end
    let(:example2) do
      Pueri::DoseCheck.new(
        weight: 18,
        dose: 0.0,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mL',
        conc_unit: 'mg/mL',
        name: 'Cefalexina',
        way: 'VO'
      )
    end
    let(:example3) do
      Pueri::DoseCheck.new(
        weight: 18,
        dose: 2.7,
        time: 0,
        days: 7,
        concentration: 50,
        dose_unit: 'mL',
        conc_unit: 'mg/mL',
        name: 'Cefalexina',
        way: 'VO'
      )
    end
    let(:example4) do
      Pueri::DoseCheck.new(
        weight: 18,
        dose: 2.7,
        time: 6,
        days: 0,
        concentration: 50,
        dose_unit: 'mL',
        conc_unit: 'mg/mL',
        name: 'Cefalexina',
        way: 'VO'
      )
    end
    let(:example5) do
      Pueri::DoseCheck.new(
        weight: 18,
        dose: 2.7,
        time: 6,
        days: 7,
        concentration: 0,
        dose_unit: 'mL',
        conc_unit: 'mg/mL',
        name: 'Cefalexina',
        way: 'VO'
      )
    end
    let(:example6) do
      Pueri::DoseCheck.new(
        weight: 18,
        dose: 2.7,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mg/mL',
        conc_unit: 'mg/mL',
        name: 'Cefalexina',
        way: 'VO'
      )
    end
    let(:example7) do
      Pueri::DoseCheck.new(
        weight: 18,
        dose: 2.7,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: '',
        conc_unit: 'mg/mL',
        name: 'Cefalexina',
        way: 'VO'
      )
    end
    let(:example8) do
      Pueri::DoseCheck.new(
        weight: 18,
        dose: 2.7,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mL',
        conc_unit: 'mg',
        name: 'Cefalexina',
        way: 'VO'
      )
    end
    let(:example9) do
      Pueri::DoseCheck.new(
        weight: 18,
        dose: 2.7,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mL',
        conc_unit: '',
        name: 'Cefalexina',
        way: 'VO'
      )
    end
    let(:example10) do
      Pueri::DoseCheck.new(
        weight: 18,
        dose: 2.7,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mL',
        conc_unit: 'mg/mL',
        name: '',
        way: 'VO'
      )
    end
    let(:example11) do
      Pueri::DoseCheck.new(
        weight: 18,
        dose: 2.7,
        time: 6,
        days: 7,
        concentration: 50,
        dose_unit: 'mL',
        conc_unit: 'mg/mL',
        name: 'Cefalexina',
        way: ''
      )
    end

    it 'checks for parameter integrity and conformity' do
      expect { example1 }.to raise_error ArgumentError
      expect { example2 }.to raise_error ArgumentError
      expect { example3 }.to raise_error ArgumentError
      expect { example4 }.to raise_error ArgumentError
      expect { example5 }.to raise_error ArgumentError
      expect { example6 }.to raise_error ArgumentError
      expect { example7 }.to raise_error ArgumentError
      expect { example8 }.to raise_error ArgumentError
      expect { example9 }.to raise_error ArgumentError
      expect { example10 }.to raise_error ArgumentError
      expect { example11 }.to raise_error ArgumentError
    end
  end
end
