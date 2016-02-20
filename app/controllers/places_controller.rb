class PlacesController < ApplicationController
  # before_action :set_place, only: [:show]

  def index
  end

  def show
    @place = BeermappingApi.get_place(params[:id])
    if @place
      render :show
    else
      redirect_to :back, notice: "Place not found"
    end
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  private

  # def set_place
  #   @place = Place.find(params[:id])
  # end
end