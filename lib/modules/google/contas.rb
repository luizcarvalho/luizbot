require_relative './auth'
require 'date'

SPREADSHEET_ID = '1LmTgrkMXqHB-tAP_MDXcgOVCI-gky_H6eMA5dGndR1s'.freeze
EXPIRATION_DATES_COLUMN = 'C'.freeze
PAYMENT_DATES_COLUMN = 'E'.freeze

class Contas
  def initialize
    @service = authorize_service
    @range = "#{EXPIRATION_DATES_COLUMN}2:#{EXPIRATION_DATES_COLUMN}100"
  end

  def close_bills_duedates
    bills_duedates = []
    expiration_dates.each do |date|
      # puts "DATE: #{date[:date]}"
      next unless verify_date_range(date[:date])

      bill = bill_info(date[:row])
      # puts "Verify payment: #{payment}"
      bills_duedates << bill unless bill[:pagamento]
    end

    bills_duedates
  end

  def expiration_dates
    row_dates = []
    response = @service.get_spreadsheet_values SPREADSHEET_ID, @range

    response.values.each_with_index do |date, index|
      next unless date[0]

      row_dates << { row: index + 2, date: convert_date(date[0]) }
    end

    row_dates
  end

  def bill_info(row)
    response = @service.get_spreadsheet_values SPREADSHEET_ID, "A#{row}:F#{row}"

    bill = response&.values&.pop
    {
      mes: bill[0], conta: bill[1], vencimento: bill[2], valor: bill[3],
      pagamento: bill[4], codigo: bill[5], row: row
    }
  end

  private

  def verify_date_range(date)
    initial_date = Date.today - 10
    final_date = Date.today + 4
    # puts "verify range: #{initial_date} <= #{date} <= #{final_date}"
    initial_date <= date && date <= final_date
  end

  def convert_date(date)
    d, m, y = date.split('/')
    Date.new(y.to_i, m.to_i, d.to_i)
  end
end
