# frozen_string_literal: true

module Pueri
  # Parses a given date string into and Array of age. The array contains the
  # years, months and days of life of the one who was/would be born on the given
  # day.
  class Age
    attr_reader :days_month, :age

    def initialize(date)
      @days_month = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
      @age = parse_age(date)
    end

    # Retrieves the age on a readable format.
    #
    # @param short [Booleann] Whether to output a short-format age or not.
    #   Defaults to long format.
    # @return [String] The age in a readable format, either short or long.
    def to_s(short = false)
      if short
        short_string
      else
        long_string
      end
    end

    # Retrieves the age in days.
    #
    # @return [Float] The age in days, rounded to the second decimal place.
    def to_f
      a = age[0].to_f * 365.25
      a += age[1].to_f * 30.0
      a += age[2].to_f
      a.round(2)
    end

    private

    def short_string
      p = Pastel.new
      "#{p.bold(age[0])}a#{p.bold(age[1])}m#{p.bold(age[2])}d"
    end

    def long_string
      p = Pastel.new
      "Idade: #{p.cyan(age[0])} anos, #{p.cyan(age[1])} meses, "\
      "#{p.cyan(age[2])} dias."
    end

    # This method takes a date in the string format "DD/MM/YYYY" and returns
    # a Time object.
    def birthday_timestamp_time(date_read)
      date = date_read.chomp
      if date =~ %r{/}
        birthday = date.split('/')
        birthday[2] = year(birthday[2])
      else
        birthday = parse_numonly_date(date)
      end
      Time.new(birthday[2], birthday[1], birthday[0])
    end

    def parse_numonly_date(date)
      if date.size == 6
        [date[0..1], date[2..3], year(date[4..5])]
      else
        [date[0..1], date[2..3], date[4..7]]
      end
    end

    def year(year)
      if year.chomp.size == 2
        if year.to_i < 30
          year.prepend('20')
        else
          year.prepend('19')
        end
      end

      year
    end

    def future_day?(day, month, birth_date, current_date, borrowed_month)
      if day.negative?
        # subtract month, get positive # for day
        day = @days_month[birth_date.month] - birth_date.day + current_date.day
        month -= 1
        borrowed_month = true
      end

      [day, month, borrowed_month]
    end

    def future_month?(month, year, birth_date, current_date, borrowed_month)
      if month.negative?
        # subtract year, get positive # for month
        month = 12 - birth_date.month + current_date.month
        month -= 1 if borrowed_month == true
        year -= 1
      end

      [month, year]
    end

    def future_year?(year, month, day)
      # Error-handling for future date
      if year.negative?
        year = 0
        month = 0
        day = 0
      end

      [year, month, day]
    end

    def check_future(day, month, year, dates, borrowed_month)
      birth_date, current_date = dates
      day, month, borrowed_month = future_day?(
        day, month, birth_date, current_date, borrowed_month
      )
      month, year = future_month?(
        month, year, birth_date, current_date, borrowed_month
      )
      year, month, day = future_year?(year, month, day)

      [day, month, year]
    end

    def check_present(current_date, birth_date)
      day   = current_date.day - birth_date.day
      month = current_date.month - birth_date.month
      year  = current_date.year - birth_date.year

      [day, month, year]
    end

    # This method takes a birthday in the string format "DD/MM/YYYY" and returns
    # the person's age.
    def parse_age(date)
      borrowed_month = false

      current_date = Time.new
      birth_date = birthday_timestamp_time(date)

      # Get days for this year
      @days_month[2] = 29 if current_date.to_date.leap?

      day, month, year = check_present(current_date, birth_date)

      day, month, year = check_future(
        day, month, year, [birth_date, current_date], borrowed_month
      )

      [year, month, day]
    end
  end
end
