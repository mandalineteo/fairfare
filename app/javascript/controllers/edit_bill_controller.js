import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-bill"
export default class extends Controller {

  static targets = ["itemDescriptions", "billHeaderText"]

  connect() {
    console.log("test from bill input")
  }

  // item & qty & unit price
  toggleForm(e) {
    this.itemDescriptionsTargets.forEach((target)=>{
      target.classList.remove("show-form");
    })
    // console.log('show form')
    const form = e.currentTarget.parentElement;
    form.classList.add("show-form");
  }

  closeForm(e){
    // console.log('close form')
    if (e.target.classList.contains("item-value") || e.target.classList.contains("form-toggler") || e.target.tagName.toLowerCase() === "input") {
      return;
    }

    this.itemDescriptionsTargets.forEach((target)=>{
      target.classList.remove("show-form");
    })
  }

  updateItem(e) {
    // console.log('tolong')
    // console.log(e.target)
    // console.log(e.target.form)
    // fire ajax here to submit form
    console.log("fire ajax for ")
    console.log(e.target.form)
  }

  // split name
  toggleSplitForm(e) {
    console.log("test from split form")
    // this.billHeaderTextTarget.remove("split-input-header")

    const splitForm = e.currentTarget.parentElement;
    splitForm.classList.add("split-input-header")
  }

  // displayHeaderForm() {
  //   console.log("test to display bill header")

  //   this.billHeaderTextTarget.classList.remove("splitInput")
  //   // console.log("class removed")
  // }

  updateSplitValue(e) {
    // console.log("fire ajax for split name ")
    // console.log(e.target.form)
  }

}
