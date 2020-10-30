require 'update/from_csv.rb'
require 'update/from_spreadsheet.rb'

namespace :update do
  task :csvfiles => :environment do
    Dir.glob('storage/Nevada_Voter_Data.csv') do |file|
      Update::FromCsvFiles.load(file)
    end
  end

  task :spreadsheet => :environment do
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE #{table} CASCADE")
    end
    Update::FromSpreadsheet.load
  end

end