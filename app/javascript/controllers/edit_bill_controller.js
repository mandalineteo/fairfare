import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-bill"
export default class extends Controller {

  static targets = [
    "itemDescriptions",
    "splitText",
    "merchantAndDate",
    "taxDescriptions",
    "splitHeader",
    "breakdown"
  ]

  connect() {
    // console.log(this.itemDescriptionsTarget);
  }

  // ====== item ======
  toggleForm(event) {
    this.itemDescriptionsTargets.forEach((target)=>{
      target.classList.remove("show-form");
    })
    // console.log('show form')
    const form = event.currentTarget.parentElement;
    form.classList.add("show-form");
  }

  closeForm(event){
    // console.log('close form')
    if (event.target.classList.contains("item-value") || event.target.classList.contains("form-toggler") || event.target.tagName.toLowerCase() === "input") {
      return;
    }
    this.itemDescriptionsTargets.forEach((target)=>{
      target.classList.remove("show-form");
    })
  }

  updateItem(event) {
    // console.log(event.target.closest('form'));
    const form = event.target.closest('form')

    fetch(form.action, {
      method: "PATCH",
      headers: { "Accept": "text/plain"},
      body: new FormData(form)
      })

      .then(response => response.text())
      .then((data) => {
        console.log(data);
        // this.itemDescriptionsTargets.innerHTML = data
      })
  }

  // ======== split name ============
  toggleSplitForm() {
    // console.log("test from split form")
    this.splitTextTarget.classList.remove("d-none")
    this.splitHeaderTarget.classList.add("d-none")
    this.splitTextTarget.focus()
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
      headers: { "Accept": "text/plain"},
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
      headers: { "Accept": "text/plain"},
      body: new FormData(this.merchantAndDateTarget)
      })

      .then(response => response.text())
      .then((data) => {
        console.log(data);
      })
  }


  // ======== taxes ==========

  updateTax(event) {
    const form = event.target.closest('form')
    const targetInput = event.target.dataset.billTarget

    const centValue = parseFloat(event.target.value) * 100
    const input = document.querySelector(`input[name="bill[${targetInput}]"]`)
    input.value = centValue

    fetch(form.action, {
      method: "PATCH",
      headers: { "Accept": "text/plain"},
      body: new FormData(form)
      })

      .then(response => response.text())
      .then((data) => {
        this.breakdownTarget.outerHTML = data
      })
  }

}
