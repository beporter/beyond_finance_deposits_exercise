# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Load any CSV files in `db/seeds/`. Can be organized using numeric
# prefixes like `01_parent.csv`, `02_child.csv` to ensure association
# integrity. CSV files are processed by ERB during load to allow for
# dynamic values.

return unless Rails.env.development?

require 'csv'
require 'erb'

Dir.glob(Rails.root.join('db', 'seeds', '*.csv')).sort.each do |csv_file|
  model = File.basename(csv_file, ".csv").slice(/\d+_(.*)/, 1).classify.constantize

  puts "Seeding '#{csv_file.sub(Rails.root.to_s, '')}' into model '#{model}'..."

  processed_csv = ERB.new(File.read(csv_file)).result

  CSV.parse(processed_csv, headers: true, skip_blanks: true).each do |row|
    record = model.find_or_create_by(row.to_hash)
    puts record.valid? ? record : record.errors.to_a
  end

  puts 'Done.'
end

