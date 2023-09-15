import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-contacts"
export default class extends Controller {
  static targets = ["list"]

  connect() {
    console.log("I am connected");
  }

  filterByFirstName(event) {
    console.log(event.target.value);
    // 1. create a route to search by this
    //      - members/filter?first_name=zohan
    const url = `members/filter?first_name=${event.target.value}`
    // 2. fetch ->
  }
}
