class Location < ApplicationRecord
  has_many :yards, dependent: :destroy
end
