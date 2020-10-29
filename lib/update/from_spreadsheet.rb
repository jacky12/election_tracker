require "google_drive"

module Update
    module FromSpreadsheet
        
        def FromSpreadsheet.load
            session = GoogleDrive::Session.from_service_account_key("election-tracker-19a00db0d21f.json")

            # Get the spreadsheet by its title
            spreadsheet = session.spreadsheet_by_title("Live Results")
            # Get the first worksheet
            worksheet = spreadsheet.worksheets.first
            # Print out the first 6 columns of each row
            worksheet.rows.each { |row| puts row.first(6).join(" | ") }
        end
    end
end