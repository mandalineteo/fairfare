import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-field"
export default class extends Controller {
  connect() {
    console.log("I am connected!")
  }
}
