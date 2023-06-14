class RevokedToken < ApplicationRecord
  validates :token, presence: true
end
