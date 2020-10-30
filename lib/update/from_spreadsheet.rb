require "google_drive"
require 'googleauth'

module Update
    module FromSpreadsheet
        def FromSpreadsheet.load
            session = nil
            if File.file?("election-tracker-19a00db0d21f.json")
                session = GoogleDrive::Session.from_service_account_key("election-tracker-19a00db0d21f.json")
            else
                auth_creds = Google::Auth::ServiceAccountCredentials.make_creds(json_key_io: StringIO.new(ENV['CREDS'])
                session = GoogleDrive::Session.from_credentials(auth_creds)
  )
            end
            spreadsheet = session.spreadsheet_by_title("Live Results")

            spreadsheet.worksheets.each do |ws|
                state_name = ws.title
                state = State.find_by(slug: state_name.parameterize)
                if !state
                    state = State.create(name: state_name.parameterize)
                end

                ws.list.each do |row|
                    county_name = row["County"]
                    county = state.counties.find_by(slug: county_name.parameterize)
                    dem_count = row["Democrat"].delete(",").to_i
                    gop_count = row["Republican"].delete(",").to_i
                    percentage_reporting = row["Percentage Reporting"].delete("%").to_i
                    if !county
                        County.create(name: county_name,
                            dem: dem_count,
                            gop: gop_count,
                            state_id: state.id,
                            percentage_precincts_reporting: percentage_reporting,
                            )
                    else
                        county.update({:dem => dem_count, :gop => gop_count, :percentage_precincts_reporting => percentage_reporting})
                    end
                end
            end
        end
    end
end