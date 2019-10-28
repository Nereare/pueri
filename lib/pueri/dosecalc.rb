# frozen_string_literal: true

module Pueri
  # Calculates the prescription of a given medication given the weight of the
  # pacient, the dose-per-weight-day, the concentration of the medication's
  # presentation and the periodicity of takes in hours.
  class DoseCalc
    attr_reader :weight, :dose, :time, :days, :concentration, :result, :name
    attr_accessor :dose_unit, :conc_unit

    # Calculate the dosage for each taking of a given medicine.
    #
    # @param params [Hash] A Hash of elements, all of which are required to
    #   properly calculate and output the final dosage-per-taking:
    #   [+:weight+]         The weight of the pacient, in _kilograms_.
    #   [+:dose+]           The dose for the pacient, in _unit/kg/day_.
    #   [+:time+]           The time between takings, in hours.
    #   [+:days+]           The number of days to take the medication.
    #   [+:concentration+]  The posologic concentration, number only.
    #   [+:dose_unit+]      The unit of dosage for the pacient (_e.g._ mg/kg/d).
    #   [+:conc_unit+]      The unit of concentration (_e.g._ mg/mL, mcg/pill).
    #   [+:name+]           The name of the medication.
    def initialize(params)
      init_vars(params)
      @result = ((@weight * @dose * @time) / (24.0 * @concentration)).round(3)
    end

    # Outputs the calculated dosage into a prescription string.
    #
    # @param pretty [Boolean] Whether to output a colored result or not.
    # @return [String] The prescription string.
    def to_s(pretty = false)
      if pretty
        pretty_to_s
      else
        [
          '',
          "- #{@name} #{@concentration.to_i}#{@conc_unit.join '/'}",
          "Tomar #{@result}#{@conc_unit[1]} #{time_to_s} #{days_to_s}."
        ].join "\n"
      end
    end

    # Outputs the calculated dosage for each taking. _E.g._ +3.7+, as in _use
    # 3.7 units of medication each time_.
    #
    # @return [Float] The dosage to be used each time one takes the medication.
    def to_f
      @result
    end

    private

    def pre_pretty_to_s
      p = Pastel.new
      qtt = p.cyan(@result, @conc_unit[1])
      time = @time.to_i.to_s.rjust(2, '0')
      time = p.cyan(time, '/', time, 'h')
      days = p.cyan(@days.to_s.rjust(2, '0'), ' dias')

      [qtt, time, days]
    end

    def pretty_to_s
      p = Pastel.new
      qtt, time, days = pre_pretty_to_s
      [
        '',
        "#{p.cyan('1.')} #{@name} #{@concentration.to_i}"\
        "#{@conc_unit.join('/')} ".ljust(90, '-'),
        "   Dar #{qtt} de #{time} por #{days}."
      ].join("\n")
    end

    def time_to_s
      if @time == 24.0
        'uma vez por dia'
      else
        time = @time.to_i.to_s.rjust(2, '0')
        hour = 'hora'
        hour += 's' if @time > 1.0
        "de #{time}/#{time} #{hour}"
      end
    end

    def days_to_s
      if @days == 1.0
        str = 'por um dia'
        str = 'em dose única' if @time == 24.0
        str
      else
        days = @days.to_i.to_s.rjust(2, '0')
        str = 'dia'
        str += 's' if @days > 1.0
        "por #{days} #{str}"
      end
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
        msg = "#{key} must follow unit/kg/d format"
        raise ArgumentError, msg unless value.match? %r{^[A-Za-z]+\/kg\/d$}
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
      @dose_unit = params[:dose_unit].split '/'
      @conc_unit = params[:conc_unit].split '/'
      @name      = params[:name].strip
    end
  end
end
