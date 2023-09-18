import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-contacts"
export default class extends Controller {
  static targets = ["list", "input", "form"]

  connect() {
    console.log("I am connected");
    console.log(this.listTarget);
    console.log(this.inputTarget);
    console.log(this.formTarget);
  }

  filterByFirstName(event) {
    console.log(event.target.value);
    // 1. create a route to search by this
    //      - members/filter?first_name=zohan
    const url = `${this.formTarget.action}?filter=${event.target.value}`
    console.log(url);
    // 2. fetch ->
    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
      })
  }
}
