require "google_drive"
require 'googleauth'
require 'update/db_func'

module Update
    module FromSpreadsheet
        def FromSpreadsheet.load
            session = nil
            if File.file?("election-tracker-19a00db0d21f.json")
                session = GoogleDrive::Session.from_service_account_key("election-tracker-19a00db0d21f.json")
            else
                session = GoogleDrive::Session.from_service_account_key(StringIO.new(ENV['CREDS']))
            end
            spreadsheet = session.spreadsheet_by_title("Live Results")

            states_to_be_removed = State.pluck(:name)


            spreadsheet.worksheets.each do |ws|
                state_name = ws.title
                state = State.find_by(slug: state_name.parameterize)
                if !state
                    state = State.create(name: state_name)
                else
                    states_to_be_removed.delete(state_name)
                end

                counties_to_be_removed = state.counties.pluck(:name)
                ws.list.each do |row|
                    county_name = row["County"]
                    county = state.counties.find_by(slug: county_name.parameterize)
                    dem_count = row["Democrat"].delete(",").to_i
                    gop_count = row["Republican"].delete(",").to_i
                    percentage_reporting = row["Percentage Reporting"].gsub(/[a-zA-Z]/,'').strip.delete("%").to_i
                    if !county
                        County.create(name: county_name,
                            dem: dem_count,
                            gop: gop_count,
                            state_id: state.id,
                            percentage_precincts_reporting: percentage_reporting,
                            )
                    else
                        county.update({:dem => dem_count, :gop => gop_count, :percentage_precincts_reporting => percentage_reporting})
                        counties_to_be_removed.delete(county_name)
                    end
                end
                remove_counties(state_name, counties_to_be_removed)
            end

            remove_states(states_to_be_removed)
        end
    end
end