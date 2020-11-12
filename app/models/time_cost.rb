class TimeCost < ApplicationRecord
  belongs_to :yard
  has_many :bookings, dependent: :destroy
end
