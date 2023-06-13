class Api::V1::AppointmentsController < ApplicationController
  before_action :authenticate_request
  def index
    @appointments = current_user.appointments.all
    if @appointments.empty?
      render json: { error: @appointments.errors.full_messages }, status: :unprocessable_entity
    else
      render json: @appointments
    end
  end

  def show
    @appointment = current_user.appointments.find_by(id: params[:id])
    if @appointment.present?
      render json: @appointment
    else
      render json: { error: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    @appointment = current_user.appointments.create(appointment_params)
    if @appointment.valid?
      render json: @appointment, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment = current_user.appointments.find(params[:id])
    if @appointment.destroy
      render json: { message: 'Appointment deleted successfully!' }, status: :ok
    else
      render json: { error: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :status, :user_id, :therapist_id)
  end
end
