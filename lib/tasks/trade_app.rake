# frozen_string_literal:true

require 'csv'

namespace :trade_app do
  desc 'Import data'
  task import_data: :environment do
    $stdout.sync = true
    filename = 'tmp/ux_sample_data.csv'

    CSV.foreach(filename, headers: true, col_sep: ',', quote_char: '"', skip_blanks: true) do |csv_row|
      print_progress
      Trade.create!(csv_row.to_hash)
    rescue ActiveModel::UnknownAttributeError => e
      replace_pattern = 'NEVADA ST GO LTD TAX BDS NEVADA MUN BD BK PROJ 87,88,89 2015F'
      raw_data = csv_row.to_s.gsub(/, /, ' ')
      raw_data = raw_data.gsub(replace_pattern, "\"#{replace_pattern}\"")
      row = CSV.parse_line(raw_data, col_sep: ',', quote_char: '"')
      trade = Trade.new(Hash[csv_row.headers.compact.zip(row)])
      trade.save!
    end
    print "\n"
  end

  private

  def print_progress
    print '.'
  end
end
