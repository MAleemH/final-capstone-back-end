class Api::V1::TherapistsController < ApplicationController
    def index
        @therapists = Therapist.all
        if @therapists.empty?
            render json:{ error: @therapists.errors.full_messages }, status: :unprocessable_entity
        else
            render json: @therapists
        end
    end
end
