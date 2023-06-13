class Api::V1::AppointmentsController < ApplicationController
    def index
        @appointments = Appointment.all
        if @appointments.empty?
            render json: { error: @appointments.errors.full_messages }, status: :unprocessable_entity
        else
            render json: @appointments
        end
    end
end
