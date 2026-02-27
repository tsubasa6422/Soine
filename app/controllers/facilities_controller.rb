# app/controllers/facilities_controller.rb
class FacilitiesController < ApplicationController
  def map
    @facilities = Facility.where.not(latitude: nil, longitude: nil)
  end
end