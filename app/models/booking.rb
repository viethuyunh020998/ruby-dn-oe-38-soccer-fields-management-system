class Booking < ApplicationRecord
  belongs_to :time_cost
  belongs_to :user

  delegate :time, :cost, to: :time_cost, prefix: true
  delegate :name, to: :location, prefix: true
  delegate :code, :type_yard, to: :yard, prefix: true

  enum status: {pending: 0, accept: 1, rejected: 2, cancel: 3}
  scope :status_asc, ->{order status: :asc}

  def yard
    time_cost&.yard
  end

  def location
    time_cost&.yard&.location
  end
end
