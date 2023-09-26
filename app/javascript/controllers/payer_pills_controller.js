import { Controller } from "@hotwired/stimulus"
import { createConsumer } from '@rails/actioncable'

// Connects to data-controller="billroom-subscription"
export default class extends Controller {
  static values = { billId: Number }

  static targets = ["payerPillsList"]

  connect() {
    console.log(`Subscribe to the bill with the id ${this.billIdValue}.`)
    console.log(this.payerPillsListTargets)

    this.channel = createConsumer().subscriptions.create(
      { channel: "PayerPillsChannel", id: this.billIdValue },
      {
        received: data => {
          console.log('payer data', data)
          // const itemMember = this.itemMemberTargets.find(target => target.dataset.id == `item-${data.item_id}-member-${data.member_id}`)
          const payerPillsList = this.payerPillsListTargets.find(target => target.dataset.id == `item-${data.item_id}`)

          // itemMember.outerHTML = data.item_member_form_html
          payerPillsList.outerHTML = data.item_member_list
        }
      }
    )
  }
}
