import { Controller } from "@hotwired/stimulus"
import { createConsumer } from '@rails/actioncable'

// Connects to data-controller="billroom-subscription"
export default class extends Controller {
  static values = { billId: Number }

  static targets = ["itemMember", "itemMemberList"]

  connect() {
    console.log(`Subscribe to the bill with the id ${this.billIdValue}.`)
    console.log(this.itemMemberTargets)
    console.log(this.itemMemberListTargets)

    this.channel = createConsumer().subscriptions.create(
      { channel: "BillRoomChannel", id: this.billIdValue },
      {
        received: data => {
          console.log(data)
          const itemMember = this.itemMemberTargets.find(target => target.dataset.id == `item-${data.item_id}-member-${data.member_id}`)
          const itemMemberList = this.itemMemberListTargets.find(target => target.dataset.id == `item-${data.item_id}`)

          itemMember.outerHTML = data.item_member_form_html
          itemMemberList.outerHTML = data.item_member_list
        }
      }
    )
  }
}
