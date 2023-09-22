import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-bill"
export default class extends Controller {

  static targets = [
    "itemDescriptions",
    "splitText",
    "merchantAndDate",
    "taxDescriptions",
    "splitHeader"
  ]

  // static values = {
  //   billId: String,
  //   splitId: String
  // data-edit-bill-split-id-value="<%=@split.id%>" data-edit-bill-bill-id-value="<%=@bill.id%>"
  // }

  connect() {

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
    event.preventDefault()
    const url = this.itemDescriptionsTargets.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain"},
      body: new FormData(this.itemDescriptionsTargets)
      })

      .then(response => response.text())
      .then((data) => {
        // console.log(data);
        this.itemDescriptionsTargets.innerHTML = data
      })
    // console.log("fire ajax for ")
    // console.log(e.target.form)
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
    // console.log("fire ajax for split name ")
    // console.log(event.target.form)
  }

  // ============ merchant's name & date =============

  toggleMerchantForm(event) {

    this.merchantAndDateTargets.forEach((target)=>{
      target.classList.remove("merchant-and-date");
    })
    // this.merchantAndDateTargets.classList.remove("merchant-and-date")

    const merchantForm = event.currentTarget.parentElement;
    merchantForm.classList.add("merchant-and-date");
  }

  closeMerchantForm(event) {
    if (event.target.classList.contains("merchant-date-value") ||event.target.classList.contains("merchant-toggler") || event.target.tagName.toLowerCase() === "input") {
      return;
    }
    this.merchantAndDateTarget.classList.remove("merchant-and-date");
  }

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
        // this.splitTextTarget.outerHTML = data
      })
    console.log("fire ajax for merchant's name ")
    console.log(e.target.form)
  }


  // ======== taxes ==========

  toggleTaxesForm(event) {
    this.taxDescriptionsTarget.classList.remove("merchant-and-date")

    const merchantForm = event.currentTarget.parentElement;
    merchantForm.classList.add("tax-and-discount");
    // console.log("taxes form");
  }

  closeTaxForm(event) {
    // console.log("close split form")

    if (event.target.classList.contains("tax-value") ||event.target.classList.contains("split-toggler") || event.target.tagName.toLowerCase() === "input") {
      return;
    }
    this.splitTextTarget.classList.remove("split-input-header");
  }

  updateTaxAndDiscount(event) {
    event.preventDefault()
    const url = this.taxDescriptionsTarget.action
    // console.log(this.taxDescriptionsTarget.action)
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain"},
      body: new FormData(this.taxDescriptionsTarget)
      })

      .then(response => response.text())
      .then((data) => {
        console.log(data);
        // this.taxDescriptionsTarget.outerHTML = data
      })
    // console.log("fire ajax for tax name ")
    // console.log(e.target.form)
  }

}
