class Therapist < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :specialization, presence: true
  validates :phone, presence: true
  validates :photo, presence: true
  validates :availability, presence: true
  validates :address, presence: true
end
