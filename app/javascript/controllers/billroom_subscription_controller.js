import { Controller } from "@hotwired/stimulus"
import { createConsumer } from '@rails/actioncable'

// Connects to data-controller="billroom-subscription"
export default class extends Controller {
  static values = { billId: Number }
  // static targets = ["messages"]

  connect() {
    console.log(`Subscribe to the bill with the id ${this.billIdValue}.`)
    this.channel = createConsumer().subscriptions.create(
      { channel: "BillRoomChannel", id: this.billIdValue },
      { received: data => console.log(data) }
    )
  }
}
