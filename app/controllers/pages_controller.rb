class PagesController < ApplicationController
  def home
    @cities = Trip.where(user_id: nil)
  end
end
