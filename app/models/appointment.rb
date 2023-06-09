class Appointment < ApplicationRecord
    belongs_to :user
    belongs_to :therapist

    validates :date, presence: true
    validates :user_id, presence: true
    validates :therapist_id, presence: true
end
