import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payer-dropdown"
export default class extends Controller {
  static targets = ["checkbox", "form"]
  static values = {
    splitId: String,
    billId: String,
    payerId: String,
    hasPayer: String
  }

  connect() {
    // this.create_url = `/splits/${this.splitIdValue}/bills/${this.billIdValue}/payers`
    this.destroy_url = `/splits/${this.splitIdValue}/bills/${this.billIdValue}/payers/${this.payerIdValue}`

    if (this.hasPayerValue === 'true') {
      console.log('hasPayer', this.hasPayerValue)
      this.checkboxTarget.classList.add("green")
    }
  }

  toggle(event) {
    event.preventDefault()

    console.log(event.target.action);

    if (this.hasPayerValue === 'false') {

      this.checkboxTarget.classList.remove("grey")
      this.checkboxTarget.classList.add("green")

      fetch(this.formTarget.action, {
        method: "POST",
        headers: { "Accept": "application/json" },
        body: new FormData(this.formTarget)
      })
        .then(response => {
          return response.json()
        })
        .then((data) => {
          console.log("data", data)
        })
    }

    if (this.hasPayerValue === 'true') {

      this.checkboxTarget.classList.remove("green")
      this.checkboxTarget.classList.add("grey")

  //     // THIS GREEN->GREY TOGGLE IS NOT WORKING BUT THE DELETE IS WORKING ????????


  //     fetch(this.destroy_url, {
  //       method: "DELETE",
  //       headers: { "Accept": "application/json" },
  //       // body: new FormData(this.formTarget)
  //     })
  //     console.log(response)
  //       .then(response => {
  //         return response.json()
  //       })
  //       .then((data) => {
  //         console.log("data", data)
  //       })
  //   }
  }
}
