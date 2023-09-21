import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-people"
export default class extends Controller {
  static targets = ["popup", "checkbox"]

  connect() {
    // console.log("add people button controller works")
  }

  appear() {
    this.popupTarget.classList.toggle("d-none");
  }

}
