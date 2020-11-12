class Booking < ApplicationRecord
  belongs_to :time_cost
  belongs_to :user
  enum status: {pending: 0, accept: 1, rejected: 2, cancel: 3}
end
