Geocoder.configure(
  # [...]
  timeout: 5, # seconds
  lookup: :mapbox, # Defaults to :nominatim, which is less reliable but free
  api_key: ENV['MAPBOX_ACCESS_TOKEN'],
  units: :km, # Defaults to miles (:mi)
  # [...]
)
