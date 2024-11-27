import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

export default class extends Controller {
  static values = { apiKey: String }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    console.log("Hello from geocoder controller")

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [2.34, 48.8],
      zoom: 10
    });

    this.geocoder = new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl,
    });

    this.#getDataOnClick()
  }

  #getDataOnClick() {
    this.map.on('click', (e) => {
      console.log(e)

      const latitude = e.lngLat.lat
      const longitude = e.lngLat.lng

      console.log(latitude, longitude)

      this.#geocodeCoordinates(latitude, longitude)
    })
  }

  #geocodeCoordinates(latitude, longitude) {
    const accessToken =  mapboxgl.accessToken;
    const url = `https://api.mapbox.com/search/geocode/v6/reverse?longitude=${longitude}&latitude=${latitude}&types=address&access_token=${accessToken}`;

    fetch(url)
      .then(response => {
        if (!response.ok) {
          throw new Error('Erreur de géocodage');
        }
        return response.json();
      })
      .then(data => {
        if (data) {
          console.log(data);
          const feature = data.features[0];
          const { properties } = feature;
          const streetName = properties.context?.address?.name || '';
          const postalCode = properties.context?.postcode?.name || '';
          const cityName = properties.context?.place?.name || '';

          this.#fillFormWithAddressData(streetName, postalCode, cityName);
        } else {
          console.log("Aucune adresse trouvée pour ces coordonnées.");
        }
      })
      .catch(error => {
        console.error("Erreur de géocodage", error);
      });
  }

  #fillFormWithAddressData(streetName, postalCode, cityName) {
    document.getElementById("place_street").value = streetName;
    document.getElementById("place_postal_code").value = postalCode;
    document.getElementById("place_city").value = cityName;
  }
};
