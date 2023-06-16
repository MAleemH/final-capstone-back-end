class Api::V1::AppointmentsController < ApplicationController
  before_action :authenticate_request
  load_and_authorize_resource
  api :GET, '/v1/users/:user_id/appointments', 'Get all appointments of the current user'
  param :user_id, :number, desc: 'id of the requested login user', required: true
  error code: 404, desc: 'Appointments not found!'
  def index
    @appointments = current_user.appointments.all
    if @appointments.empty?
      render json: { error: @appointments.errors.full_messages }, status: :unprocessable_entity
    else
      render json: @appointments
    end
  end

  api :GET, '/v1/users/:user_id/appointments/:id', 'Get appointment of the current user'
  param :user_id, :number, desc: 'id of the requested login user', required: true
  param :id, :number, desc: 'id of the requested appointment', required: true
  error code: 404, desc: 'Appointment not found!'
  def show
    @appointment = current_user.appointments.find_by(id: params[:id])
    if @appointment.present?
      render json: @appointment
    else
      render json: { error: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  api :POST, '/v1/users/:user_id/appointments', 'Create appointment for the current user'
  param :user_id, :number, desc: 'User id', required: true
  param :appointment, Hash, desc: 'Appointment info', required: true do
    param :date, String, desc: 'Appointment date', required: true
    param :status, String, desc: 'Appointment status', default_value: 'scheduled'
    param :user_id, :number, desc: 'User id', required: true
    param :therapist_id, :number, desc: 'Therapist id', required: true
  end
  error code: 404, desc: 'Appointment not created!'
  def create
    @appointment = current_user.appointments.create(appointment_params)
    if @appointment.valid?
      render json: @appointment, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/v1/users/:user_id/appointments/:id', 'Delete appointment of the current user'
  param :user_id, :number, desc: 'id of the requested login user', required: true
  param :id, :number, desc: 'id of the requested appointment', required: true
  error code: 404, desc: 'Appointment not deleted!'
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
