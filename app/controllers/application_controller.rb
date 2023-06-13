class ApplicationController < ActionController::API
  before_action :authenticate_request, except: %i[sign_in create update]
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = authorize_token
    return if @current_user

    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def authorize_token
    token = extract_token
    return unless token

    if revoked_token?(token)
      @current_user = nil
      return
    end

    decoded_token = decode_token(token)
    User.find_by(id: decoded_token['sub']) if decoded_token
  rescue JWT::DecodeError
    nil
  end

  def extract_token
    header = request.headers['Authorization']
    header&.split(' ')&.last if header
  end

  def decode_token(token)
    @decoded_token = JWT.decode(token, ENV.fetch('SECRET_KEY_BASE', nil), true, algorithm: 'HS256').first
  end

  def revoked_token?(token)
    RevokedToken.exists?(token:)
  end
end
