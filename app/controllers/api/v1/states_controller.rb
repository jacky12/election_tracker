class Api::V1::StatesController < ApplicationController
    protect_from_forgery with: :null_session
    def index
        states = State.all
        render json: StateSerializer.new(states, options).serialized_json
    end

    def create
        state = State.new(state_params)

        if state.save
            render json: StateSerializer.new(state).serialized_json
        else
            render json: { error: state.errors.messages }, status: 422
        end
    end

    def show
        puts params[:slug]
        state = State.find_by(slug: params[:slug])

        render json: StateSerializer.new(state, options).serialized_json
    end

    def update
        state = State.find_by(slug: params[:slug])

        if state.update(state_params)
            render json: StateSerializer.new(state, options).serialized_json
        else
            render json: { error: state.errors.messages }, status: 422
        end
    end

    def destroy
        state = State.find_by(slug: params[:slug])

        if state.destroy
            head :no_content
        else
            render json: { error: state.errors.messages }, status: 422
        end
    end

    private

    def state_params
        params.require(:state).permit(:name)
    end

    def options
        @options ||= { include: %i[counties] }
    end
end
