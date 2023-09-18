import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-contacts"
export default class extends Controller {
  static targets = ["list", "form", "contacts"]

  connect() {
    console.log("I am connected");
    console.log(this.listTarget);
    console.log(this.formTarget);

    this.url = '/members/filter'
    this.firstName = '';
    this.lastName = '';
    this.phoneNumber = '';
  }

  filterByFirstName(event) {
    this.firstName = event.target.value
    this.filterMembers()
  }

  filterByLastName(event) {
    this.lastName = event.target.value
    this.filterMembers()
  }

  filterByPhoneNumber(event) {
    this.phoneNumber = event.target.value
    this.filterMembers()
  }

  filterMembers() {
    fetch(`${this.url}?first_name=${this.firstName}&last_name=${this.lastName}&phone_number=${this.phoneNumber}`)
  }
}
