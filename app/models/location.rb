class Location < ApplicationRecord
  has_many :yards, dependent: :destroy

  scope :order_by_name, ->{order :name}
end
