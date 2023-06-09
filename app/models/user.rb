class User < ApplicationRecord
    has_many :appointments dependent: :destroy
    has_many :therapists

    validates :name, presence: true uniqueness: true
    validates :email, presence: true
    validates :role, presence: true
end
