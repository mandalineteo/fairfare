import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payer-dropdown"
export default class extends Controller {
  static targets = ["name", "input"]

  connect() {
    console.log("payer controller works")
  }

  // select() {
  //   this.inputTarget.value = this.nameTarget.
  // }
}
