# frozen_string_literal: true

# Gets input from child vaccination calendar for children (PNI) and an age in
# days. With this, process which vaccines are due by that age.
class Vax
  attr_reader :header, :calendar, :notes
  attr_reader :range, :table

  def initialize(norm_age)
    init_base
    @range = calc_range(norm_age)
    parse_calendar
  end

  # Retrieves the notes for the vaccination calendar, prettified.
  #
  # @return [String] The notes for the vaccines' calendar.
  def parse_notes
    r = ''
    max = @notes.size
    p = Pastel.new

    @notes.each_with_index do |line, k|
      pre = ' ' * (max - (k + 1))
      pre += '*' * (k.to_i + 1)
      r += "\n#{p.cyan(pre)} #{line}"
    end

    r
  end

  private

  def init_base
    init_header
    init_calendar
    init_notes
  end

  def init_header
    @header = ['BCB', 'HepB', 'Penta', 'Polio', 'Pneumo 10V', 'Rota',
               'MeningoC', 'FA', 'HepA', 'SCR', 'Tetra*', 'Varicela',
               'HPV', 'Influenza']
  end

  def init_calendar
    part1 = init_calendar1
    part2 = init_calendar2
    @calendar = part1.concat part2
  end

  def init_calendar1
    [
      ['DU', '1ª', '', '', '', '', '', '', '', '', '', '', '', ''],
      ['', '', '1ª', '1ª VIP', '1ª', '1ª', '', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '1ª', '', '', '', '', '', '', ''],
      ['', '', '2ª', '2ª VIP', '2ª', '2ª', '', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '2ª', '', '', '', '', '', '', ''],
      ['', '', '3ª', '3ª VIP', '', '', '', '', '', '', '', '', '', '**']
    ]
  end

  def init_calendar2
    [
      ['', '', '', '', '', '', '', 'DU', '', '', '', '', '', '**'],
      ['', '', '', '', 'Ref', '', 'Ref', '', '', '1ª', '', '', '', '**'],
      ['', '', 'DTP', '1ª VOP', '', '', '', '', 'DU', '', 'DU', '', '', '**'],
      ['', '', 'DTP', '2ª VOP', '', '', '', '', '', '', '', 'DU', '', '**'],
      ['', '', '', '', '', '', '', '', '', '', '', '', '***', '']
    ]
  end

  def init_notes
    @notes = [
      'A vacina tetra viral corresponde à segunda dose de SCR e a uma dose de '\
      'Varicela.',
      'A partir dos 6 meses aos 6 anos incompletos, uma dose por ano, exceto '\
      'no primeiro ano de vida, quase se oferta duas doses.',
      'Meninas de 9 a 14 anos. Meninos de 11 a 14 anos. Duas doses com '\
      'intervalo de 6 meses.'
    ]
  end

  def parse_calendar
    table_obj = TTY::Table.new(header: @header) do |table_line|
      @calendar[0..@range].each do |line|
        table_line << line
      end
    end
    @table = table_obj.render(:unicode, alignment: :center)
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
  # Disabled rubocop for this method for breaking this switch apart will make it
  # less readable than keeping it as a whole logic.
  def calc_range(norm_age)
    r = case norm_age
        when 0.0..59.99 then 0
        when 60.0..89.99 then 1
        when 90.0..119.99 then 2
        when 120.0..149.99 then 3
        when 150.0..179.99 then 4
        when 180.0..269.99 then 5
        when 270.0..365.24 then 6
        when 365.25..455.24 then 7
        when 455.25..1460.99 then 8
        when 1461.0..3287.24 then 9
        when 3287.25..50_000.0 then 10
        else -1
        end
    r
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength
end
