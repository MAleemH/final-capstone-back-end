class Api::V1::TherapistsController < ApplicationController
  before_action :authenticate_request
  load_and_authorize_resource
  def index
    @therapists = Therapist.all
    if @therapists.empty?
      render json: { error: @therapists.errors.full_messages }, status: :unprocessable_entity
    else
      render json: @therapists
    end
  end

  def show
    @therapist = Therapist.find_by(id: params[:id])
    if @therapist.present?
      render json: @therapist
    else
      render json: { error: "Therapist doesn't found!" }, status: 404
    end
  end

  def create
    @therapist = current_user.therapists.create(therapist_params)
    if @therapist.valid?
      render json: @therapist, status: :created
    else
      render json: @therapist.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @therapist = current_user.therapists.find(params[:id])
    if @therapist.destroy
      render json: { message: 'Therapist deleted successfully!' }, status: :ok
    else
      render json: { error: @therapist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def therapist_params
    params.require(:therapist).permit(:name, :email, :specialization, :phone, :photo, :availability, :address, :user_id)
  end
end
