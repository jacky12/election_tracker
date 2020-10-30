def remove_counties(state_name, county_names)
    state = State.find_by(name: state_name)
    county_names.each do |county_name|
        state.counties.delete_by(name: county_name)
    end
end

def remove_states(state_names)
    state_names.each do |state_name|
        state = State.find_by(name: state_name)
        state.counties.delete_all
        State.delete_by(name: state_name)
    end
end