class PlacesController < ApplicationController
  def index
    @places = Place.all

    @markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window_html: render_to_string(partial: "places_info", locals: {place: place}),
        marker_html: render_to_string(partial: "marker")
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: @places }
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      redirect_to places_path
    else
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :street, :postal_code, :city, :place_type, :country)
  end
end
