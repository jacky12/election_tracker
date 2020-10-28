require 'madison'
require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Madison.states.map do |state|
    State.create(name: state['name'])
end

results = CSV.parse(File.read("./storage/2016_US_County_Level_Presidential_Results.csv"), headers: true)
puts results.length
results.map do |entry|
    full_state_name = Madison.get_name(entry['state_abbr'])
    state = State.find_by(slug: full_state_name.parameterize)
    percentage_precincts_reporting = rand(100)
    # total_precincts = rand(100)
    # precincts_reporting = rand(total_precincts)
    county_name = entry['county_name']
    if county_name.include?(" County")
        county_name = county_name.split(" County").first
    end

    County.create(name: county_name, 
        dem: entry['votes_dem'], 
        gop: entry['votes_gop'], 
        state_id: state.id, 
        percentage_precincts_reporting: percentage_precincts_reporting
        # precincts_reporting: precincts_reporting,
        # total_precincts: total_precincts
    )
end