# app/models/facility.rb
class Facility < ApplicationRecord
  enum category: { park: 0, hospital: 1, support_center: 2, other: 99 }
  validates :name, presence: true
end