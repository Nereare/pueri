# frozen_string_literal: true

module Pueri
  # Checks the prescription of a given medication given the weight of the
  # pacient, the dose-per-take, the concentration of the medication's
  # presentation and the periodicity of takes in hours.
  class DoseCheck
    attr_reader :weight, :dose, :time, :concentration, :result, :name
    attr_accessor :dose_unit, :conc_unit, :way

    # Calculate the dosage-per-weight-day for the prescribed medicine.
    #
    # @param params [Hash] A Hash of elements, all of which are required to
    #   properly calculate and output the final dosage-per-weight-day:
    #   [+:weight+]         The weight of the pacient, in _kilograms_.
    #   [+:dose+]           The dose for the pacient, in any given _unit_.
    #   [+:time+]           The time between takings, in hours.
    #   [+:concentration+]  The posologic concentration, number only.
    #   [+:dose_unit+]      The unit of medication for each taking (_e.g._ mL).
    #   [+:conc_unit+]      The unit of concentration (_e.g._ mg/mL, mcg/pill).
    #   [+:way+]            The way of admnistration (_e.g._ IV, SC).
    #   [+:name+]           The name of the medication.
    def initialize(params)
      init_vars(params)
      @result = ((@dose * @concentration * 24.0) / (@time * @weight)).round(3)
    end

    # Outputs the calculated dosage as a string.
    #
    # @param pretty [Boolean] Whether to output a colored result or not.
    # @return [String] The dosage-per-weight-day string.
    def to_s(pretty = false)
      if pretty
        pretty_to_s
      else
        [
          '',
          "#{@name} #{@concentration.to_i}#{@conc_unit.join '/'} (#{usage})",
          " - Dose de #{@result}#{@conc_unit[0]}/kg/d."
        ].join "\n"
      end
    end

    # Outputs the calculated dosage-per-weight-day as a float.
    #
    # @return [Float] The dosage prescribe as a float, without units.
    def to_f
      @result
    end

    private

    def pretty_to_s
      p = Pastel.new
      [
        '',
        "#{p.cyan(@name, ' ', @concentration.to_i, @conc_unit.join('/'))} "\
        "(#{usage}) ".ljust(90, '-'),
        " - Dose de #{p.cyan(@result, @conc_unit[0], '/kg/d')}."
      ].join("\n")
    end

    def usage
      time = @time.to_i
      "#{@dose}#{@dose_unit} #{@way} #{time}/#{time}h por #{@days.to_i}d"
    end

    def init_vars(params)
      check_vars(params)
      init_calc_vars(params)
      init_str_vars(params)
    end

    def check_vars(params)
      params.each do |key, value|
        if value.is_a? String
          check_str_var(key, value)
        elsif value.zero?
          raise ArgumentError, "#{key} must not be zero"
        end
      end
    end

    def check_str_var(key, value)
      raise ArgumentError, "#{key} must not be zero" if value.empty?

      if key == :dose_unit
        msg = "#{key} must follow 'unit' format"
        raise ArgumentError, msg unless value.match?(/^[A-Za-z]+$/)
      elsif key == :conc_unit
        msg = "#{key} must follow unit/presentation format"
        raise ArgumentError, msg unless value.match? %r{^[A-Za-z]+\/[A-Za-z]+$}
      end
    end

    def init_calc_vars(params)
      @weight        = params[:weight].to_f
      @dose          = params[:dose].to_f
      @time          = params[:time].to_f
      @days          = params[:days].to_i
      @concentration = params[:concentration].to_f
    end

    def init_str_vars(params)
      @dose_unit = params[:dose_unit].strip
      @conc_unit = params[:conc_unit].split '/'
      @name      = params[:name].strip
      @way       = params[:way].strip
    end
  end
end
