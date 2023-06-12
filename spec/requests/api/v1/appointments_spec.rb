require 'rails_helper'

RSpec.describe "Api::V1::Appointments", type: :request do
  describe "GET /–-api" do
    it "returns http success" do
      get "/api/v1/appointments/–-api"
      expect(response).to have_http_status(:success)
    end
  end

end
