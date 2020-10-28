require 'update/from_csv.rb'

namespace :update do
  task :csvfiles => :environment do
    Dir.glob('storage/Nevada_Voter_Data.csv') do |file|
      Update::FromCsvFiles.load(file)
    end
  end

end