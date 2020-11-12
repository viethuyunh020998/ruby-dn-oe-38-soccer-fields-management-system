class Yard < ApplicationRecord
  belongs_to :location
  has_many :time_costs, dependent: :destroy
end
