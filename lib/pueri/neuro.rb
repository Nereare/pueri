# frozen_string_literal: true

module Pueri
  # Class description here
  class Neuro
    attr_reader :range, :header, :social, :motor, :lang, :table

    def initialize(norm_age)
      @range = calc_range(norm_age)
      init_tables
      mount_table
    end

    private

    def mount_table
      adjust_length
      table_obj = TTY::Table.new @header, make_lines
      @table = table_obj.render :unicode
    end

    def adjust_length
      max_length = num_lines
      adjust_length_social(max_length)
      adjust_length_motor(max_length)
      adjust_length_lang(max_length)
    end

    def adjust_length_social(max_length)
      return unless @social.size < max_length

      (max_length - @social.size).times do
        @social.append ''
      end
    end

    def adjust_length_motor(max_length)
      return unless @motor.size < max_length

      (max_length - @motor.size).times do
        @motor.append ''
      end
    end

    def adjust_length_lang(max_length)
      return unless @lang.size < max_length

      (max_length - @lang.size).times do
        @lang.append ''
      end
    end

    def make_lines
      [@social, @motor, @lang].transpose
    end

    def num_lines
      n = @social.size
      n = @motor.size if @motor.size > n
      n = @lang.size if @lang.size > n
      n
    end

    def init_tables
      init_header
      init_social
      init_motor
      init_lang
    end

    def init_header
      @header = %w[
        Social
        Motor
        Linguagem
      ]
    end

    def init_social
      social = [
        'Mamar, evacuar e dormir.',
        'Fixa o olhar com o examinador',
        'Sorriso social',
        'Leva a mão a objetos', '', '',
        'Estranhamento social', '',
        'Dá tchau e bate palma',
        'Imita atividades da casa', '', ''
      ]
      @social = social[0..@range].reject(&:empty?)
    end

    def init_motor
      motor = [
        '', '', '',
        'Fixa polo cefálico',
        'Senta com apoio',
        'Senta sem apoio, pinça superior',
        'Fica em pé com ajuda', '', '',
        'Primeiros passos', '', ''
      ]
      @motor = motor[0..@range].reject(&:empty?)
    end

    def init_lang
      lang = [
        '', '', '', '',
        'Lalação', '', '',
        'Primeiras palavras', '',
        'Palavra frase',
        'Junta duas palavras',
        'Fases gramaticais'
      ]
      @lang = lang[0..@range].reject(&:empty?)
    end

    def out_of_range
      m = 'The given age is out of reality bounds'
      raise ArgumentError, m
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
    # Disabled rubocop for this method for breaking this switch apart will make
    # it less readable than keeping it as a whole logic.
    def calc_range(age)
      r = case age
          when 0.01..59.99 then 0
          when 60.0..89.99 then 1
          when 90.0..119.99 then 2
          when 120.0..179.99 then 3
          when 180.0..269.99 then 4
          when 270.0..299.99 then 5
          when 300.0..365.24 then 6
          when 365.25..455.24 then 7
          when 455.25..545.24 then 8
          when 545.25..730.49 then 9
          when 730.5..1095.74 then 10
          when 1095.75..50_000.0 then 11
          else out_of_range
          end
      r
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength
  end
end
