import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="articles-filter"
export default class extends Controller {
  connect() {
    console.log("Connected")
  }
}
