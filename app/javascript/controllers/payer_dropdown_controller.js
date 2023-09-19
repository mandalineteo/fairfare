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
    this.create_url = `/splits/${this.splitIdValue}/bills/${this.billIdValue}/payers`
    // this.destroy_url = `/splits/${this.splitIdValue}/bills/${this.billIdValue}/payers/${this.payerIdValue}`
    // console.log(this.create_url)

    // if has payer is true, add green

    if (this.hasPayerValue === 'true') {
      console.log('hasPayer', this.hasPayerValue)
      this.checkboxTarget.classList.add("green")
    }
  }


  check(event) {
    event.preventDefault()

    this.checkboxTarget.classList.remove("add")
    this.checkboxTarget.classList.add("green")

    fetch(this.create_url, {
      method: "POST", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => {
        return response.json()
      })
      .then((data) => {
        console.log("data", data)
        // if (data.inserted_item) {
        //   this.checkboxTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        // }
        // this.formTarget.outerHTML = data.form
      })
  }
}
