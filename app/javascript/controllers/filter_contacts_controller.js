import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-contacts"
export default class extends Controller {
  static targets = ["list", "form", "contacts"]

  connect() {
    console.log("I am connected");
    console.log(this.listTarget);
    console.log(this.formTarget);
    console.log(this.contactsTarget);

    this.url = '/contacts/filter'
    this.nickname = '';
  }

  filterByNickname(event) {
    this.nickname = event.target.value
    this.filterMembers()
  }

  filterMembers() {
    fetch(`${this.url}?nickname=${this.nickname}`, { headers: { "Accept": "application/json" } })
      .then(response => response.text())
      .then((data) => {
        console.log(data)
        this.contactsTarget.innerHTML = data
      })
  }
}
