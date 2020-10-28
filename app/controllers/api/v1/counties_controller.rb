class Api::V1::CountiesController < ApplicationController
    protect_from_forgery with: :null_session
    def create
        county = state.counties.new(county_params)

        if county.save
            render json: CountySerializer.new(county).serialized_json
        else
            render json: { error: county.errors.messages }, status: 422
        end
    end

    def update
        county = County.find(params[:id])
        
        if county.update(county_params)
            render json: CountySerializer.new(county).serialized_json
        else
            render json: { error: county.errors.messages }, status: 422
        end
    end

    private

    def state
        @state ||= State.find(params[:state_id])
    end

    def county_params
        params.require(:county).permit(:name, :dem, :gop, :state_id)
    end
end