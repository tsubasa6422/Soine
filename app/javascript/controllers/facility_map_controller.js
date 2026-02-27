// app/javascript/controllers/facility_map_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { apiKey: String, facilities: Array }

  connect() {
  console.log("facility-map connected");
  this.loadGoogleMaps().then(() => this.initMap())
  }
  

  loadGoogleMaps() {
    if (window.google && window.google.maps) return Promise.resolve()
    if (this._loadingPromise) return this._loadingPromise

    this._loadingPromise = new Promise((resolve, reject) => {
      const script = document.createElement("script")
      script.src = `https://maps.googleapis.com/maps/api/js?key=${this.apiKeyValue}`
      script.async = true
      script.defer = true
      script.onload = resolve
      script.onerror = reject
      document.head.appendChild(script)
    })
    return this._loadingPromise
  }

  initMap() {
    const facilities = this.facilitiesValue || []
    const center = facilities.length
      ? { lat: facilities[0].latitude, lng: facilities[0].longitude }
      : { lat: 35.681236, lng: 139.767125 } // fallback: 東京駅

    const map = new google.maps.Map(this.element, {
      zoom: facilities.length ? 13 : 11,
      center
    })

    const infoWindow = new google.maps.InfoWindow()

    facilities.forEach((f) => {
      const marker = new google.maps.Marker({
        map,
        position: { lat: f.latitude, lng: f.longitude },
        title: f.name
      })

      marker.addListener("click", () => {
        infoWindow.setContent(`
          <div style="min-width:220px">
            <div style="font-weight:700;margin-bottom:6px;">${f.name}</div>
            <div>${f.address || ""}</div>
          </div>
        `)
        infoWindow.open({ anchor: marker, map })
      })
    })
  }
}