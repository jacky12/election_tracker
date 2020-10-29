require "google_drive"

module Update
    module FromSpreadsheet
        
        def FromSpreadsheet.load
            session = GoogleDrive::Session.from_service_account_key("election-tracker-19a00db0d21f.json")
            spreadsheet = session.spreadsheet_by_title("Live Results")

            spreadsheet.worksheets.each do |ws|
                state_name = ws.title
                state = State.find_by(slug: state_name.parameterize)

                ws.list.each do |row|
                    county_name = row["County"]
                    county = state.counties.find_by(slug: county_name.parameterize)

                    county.update({:dem => row["Biden"], :gop => row["Trump"], :percentage_precincts_reporting => row["Percentage Reporting"]})
                end

            end
        end
    end
end