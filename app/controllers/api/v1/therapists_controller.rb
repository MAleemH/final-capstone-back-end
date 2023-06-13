class Api::V1::TherapistsController < ApplicationController
    def index
        @therapists = Therapist.all
        if @therapists.empty?
            render json:{ error: @therapists.errors.full_messages }, status: :unprocessable_entity
        else
            render json: @therapists
        end
    end
    def show
        @therapist = Therapist.find_by(id: params[id])
        if @therapist.present?
            render json: @therapist
        else
            render json: { error: "Therapist doesn't found!"}, status: 404
        end
    end

    private

    def therapist_params
        params.require(:therapist).permit(:name, :email, :specialization, :phone, :photo, :availability, :address, :user_id)
    end
end
