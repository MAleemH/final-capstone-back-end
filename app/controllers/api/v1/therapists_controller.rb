class Api::V1::TherapistsController < ApplicationController
  before_action :authenticate_request
  load_and_authorize_resource
  api :GET, '/v1/users/:user_id/therapists', 'Get all therapists for current user'
  param :user_id, :number, desc: 'id of the requested login user', required: true
  error code: 404, desc: 'Therapists not found!'
  def index
    @therapists = Therapist.all
    if @therapists.empty?
      render json: { error: @therapists.errors.full_messages }, status: :unprocessable_entity
    else
      render json: @therapists
    end
  end

  api :GET, '/v1/users/:user_id/therapists/:id', 'Get requested therapist for current user'
  param :user_id, :number, desc: 'id of the requested login user', required: true
  param :id, :number, desc: 'id of the requested therapist', required: true
  error code: 404, desc: 'Therapist not found!'
  def show
    @therapist = Therapist.find_by(id: params[:id])
    if @therapist.present?
      render json: @therapist
    else
      render json: { error: "Therapist doesn't found!" }, status: 404
    end
  end

  api :POST, '/v1/users/:user_id/therapists', 'Create a new therapist by current user'
  param :user_id, :number, desc: 'User id', required: true
  param :therapist, Hash, desc: 'Therapist info', required: true do
    param :name, String, desc: 'Therapist name', required: true
    param :email, String, desc: 'Therapist email', required: true
    param :specialization, String, desc: 'Therapist specialization', required: true
    param :phone, String, desc: 'Therapist phone', required: true
    param :photo, String, desc: 'Therapist photo', required: true
    param :availability, :boolean, desc: 'Therapist availability', default_value: true
    param :address, String, desc: 'Therapist address', required: true
  end
  error code: 404, desc: 'Therapist not created!'
  def create
    @therapist = current_user.therapists.create(therapist_params)
    if @therapist.valid?
      render json: @therapist, status: :created
    else
      render json: @therapist.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/v1/users/:user_id/therapists/:id', 'Delete therapist by id'
  param :user_id, :number, desc: 'id of the requested login user', required: true
  param :id, :number, desc: 'id of the requested therapist', required: true
  error code: 404, desc: 'Therapist not deleted!'
  def destroy
    authorize! :destroy, Therapist
    @therapist = Therapist.find(params[:id])
    if @therapist.destroy
      render json: { message: 'Therapist deleted successfully!' }, status: :ok
    else
      render json: { error: 'Failed to delete the therapist.' }, status: :unprocessable_entity
    end
  end

  private

  def therapist_params
    params.require(:therapist).permit(:name, :email, :specialization, :phone, :photo, :availability, :address, :user_id)
  end
end
