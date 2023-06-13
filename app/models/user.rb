class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :appointments, dependent: :destroy
  has_many :therapists

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  def jwt_payload
    super.merge('jti' => SecureRandom.uuid)
  end

  def clear_jwt_token
    return unless jti.present?

    revoke_jwt_token(authentication_token)
    self.authentication_token = nil
    save
  end

  private

  def revoke_jwt_token(token)
    RevokedToken.create(token:)
  end

  def jwt_revoked?(_payload, token)
    RevokedToken.exists?(token:) || authentication_token.nil?
  end
end
