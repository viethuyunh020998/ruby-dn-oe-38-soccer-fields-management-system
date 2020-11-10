class Booking < ApplicationRecord
  belongs_to :time_cost
  belongs_to :user
end
