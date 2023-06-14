class Therapist < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :specialization, presence: true
  validates :phone, presence: true, uniqueness: true
  validates :photo, presence: true
  validates :address, presence: true
end
