require 'csv'

module Update
  module FromCsvFiles

    def FromCsvFiles.load(file)
      csv = CSV.parse(File.read(file), headers: true)
      state_name = 'nevada'
      state = State.find_by(slug: state_name)
      (15..4200).step(15) do |time|
        puts "Waiting for 5 seconds"
        sleep(5)
        csv.each do |row|
            county_name = row[1]
            candidate = row[2]
            votes, percentage_reporting = row["Time: #{time}"].split("_")

            county = state.counties.find_by(slug: county_name.parameterize)

            if candidate == 'Hillary'
                county.update({:dem => votes, :percentage_precincts_reporting => percentage_reporting})
                # county.dem = row["Time: #{time}"]
            end
            if candidate == 'Trump'
                county.update({:gop => votes, :percentage_precincts_reporting => percentage_reporting})
                # county.gop = row["Time: #{time}"]
            end
        end
    end
end
end
end