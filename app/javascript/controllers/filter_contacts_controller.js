import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-contacts"
export default class extends Controller {
  static targets = ["form", "contacts", "create", "toggle", 'submit', 'input']
  static values = {
    splitId: String,
    memberId: String
  }

  connect() {
    // console.log(this.splitIdValue);
    this.url = `/splits/${this.splitIdValue}/contacts/filter`
    this.nickname = '';
  }

  filterByNickname(event) {
    this.nickname = event.target.value
    this.filterContacts()
    this.validateForm()
  }

  filterContacts() {
    fetch(`${this.url}?nickname=${this.nickname}`, { headers: { "Accept": "application/json" } })
      .then(response => response.json())
      .then((data) => {
        // console.log(data.contacts)
        this.contactsTarget.innerHTML = data.contacts
        if (data.total_count === 0) {
          this.toggle()
        } else {
          this.back()
        }
      })
  }

  toggle() {
    this.createTarget.classList.remove("d-none");
    this.toggleTarget.classList.add("d-none");
  }

  back() {
    this.createTarget.classList.add("d-none");
    this.toggleTarget.classList.remove("d-none");
  }

  validateForm() {
    // if (this.inputTargets.every(input => input.value !== '')) {
    //   this.submitTarget.disabled = false
    // } else {
    //   this.submitTarget.disabled = true
    // }
    this.submitTarget.disabled = !this.inputTargets.every(input => input.value !== '')
  }

  // delete(event) {
  //   event.preventDefault();
  //   const splitId = this.splitIdValue;
  //   const memberId = event.currentTarget.dataset.filterContactsMemberIdValue

  //   fetch(`/splits/${splitId}/split_members/${memberId}`), {
  //     method: "DELETE",
  //     headers: {
  //       "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
  //       Accept: 'application/json'
  //     }
  //       .then((response) => {
  //         if (response.ok) {
  //           this.element.remove();
  //         } else {
  //           console.error("Unable to delete contact from split.");
  //         }
  //       })
  //       .catch((error) => {
  //         console.error("An error occurred:", error);
  //       })
  //   }
  // }
}
