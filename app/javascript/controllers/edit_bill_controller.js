import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-bill"
export default class extends Controller {

  static targets = [
    "itemDescriptions",
    "splitText",
    "merchantAndDate",
    "taxDescriptions",
    "splitHeader",
    "breakdown",
    "total",
    "payer",
    "payerPillsList"
  ]

  connect() {
  }

  // ====== item ======
  toggleForm(event) {
    this.itemDescriptionsTargets.forEach((target) => {
      target.classList.remove("show-form");
    })
    // console.log('show form')
    const form = event.currentTarget.parentElement;
    form.classList.add("show-form");
  }

  closeForm(event) {
    console.log('close form')
    if (event.target.classList.contains("item-value") || event.target.classList.contains("form-toggler") || event.target.tagName.toLowerCase() === "input") {
      console.log("don't close")
      return;
    }
    this.itemDescriptionsTargets.forEach((target) => {
      target.classList.remove("show-form");
    })
  }

  updateItem(event) {
    // console.log(event.target.closest('form'));
    const form = event.target.closest('form')

    const targetInput = event.target.dataset.itemTarget

    if (targetInput === "price") {
      const centValue = parseFloat(event.target.value) * 100
      const input = event.target.parentElement.querySelector(`input[name="item[price]"]`)
      input.value = centValue
    }

    fetch(form.action, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(form)
    })

      .then(response => response.text())
      .then((data) => {
        // console.log(data);
        // this.itemDescriptionsTargets.innerHTML = data
      })

    this.calculateTotal()
  }

  // ======== split name ============
  toggleSplitForm() {
    // console.log("test from split form")
    this.splitTextTarget.classList.remove("d-none")
    this.splitHeaderTarget.classList.add("d-none")
    this.splitTextTarget.focus()

    this.splitTextTarget.querySelector("#split_name").focus()
  }

  closeSplitForm() {
    this.splitTextTarget.classList.add("d-none")
    this.splitHeaderTarget.classList.remove("d-none")
  }

  updateSplitValue(event) {
    event.preventDefault()

    const url = this.splitTextTarget.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.splitTextTarget)
    })

      .then(response => response.text())
      .then((data) => {

        this.splitHeaderTarget.innerText = data
        this.closeSplitForm()

      })
  }

  // ============ merchant's name & date =============

  updateMerchantValue(event) {
    event.preventDefault()
    const url = this.merchantAndDateTarget.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.merchantAndDateTarget)
    })

      .then(response => response.text())
      .then((data) => {
        // console.log(data);
      })
  }


  // ======== taxes ==========

  updateTax(event) {
    console.log("test")
    const form = event.target.closest('form')
    const targetInput = event.target.dataset.billTarget

    const centValue = parseFloat(event.target.value) * 100
    const input = document.querySelector(`input[name="bill[${targetInput}]"]`)
    input.value = centValue

    fetch(form.action, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(form)
    })

      .then(response => response.text())
      .then((data) => {
        this.breakdownTarget.outerHTML = data
      })

    this.calculateTotal();
  }

  calculateTotal() {
    console.log("trigger")
    let total = 0
    // run the calculations
    this.itemDescriptionsTargets.forEach((form) => {
      const quantity = form.querySelector("input#item_quantity").value
      const price = form.querySelector("input#item_price").value
      // console.log(itemDescriptionsTargets)
      // console.log(price, quantity)

      total += (price * quantity)
    })

    // update the target

    const tax = Number(this.taxDescriptionsTarget.querySelector("input#bill_taxes").value)
    const svc = Number(this.taxDescriptionsTarget.querySelector("input#bill_service_charge").value)
    const discount = Number(this.taxDescriptionsTarget.querySelector("input#bill_discount").value)
    console.log('test')
    console.log({
      total, tax, svc, discount
    })
    total = total + tax + svc - discount

    // const total_in_dollars = (total/100).toFixed(2)
    // const total_after_taxes = total_in_dollars + tax + svc - discount
    // this.totalTarget.innerHTML = total_after_taxes

    console.log(this.totalTarget)
    this.totalTarget.innerHTML = (total / 100).toFixed(2)
  }

}
