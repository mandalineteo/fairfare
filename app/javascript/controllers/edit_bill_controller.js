import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-bill"
export default class extends Controller {

  static targets = ["itemDescriptions"]

  connect() {
    console.log("test from bill input")
  }

  toggleForm(e) {
    this.itemDescriptionsTargets.forEach((target)=>{
      target.classList.remove("show-form");
    })
    console.log('show form')
    const form = e.currentTarget.parentElement;
    form.classList.add("show-form");
  }

  closeForm(e){
    console.log('close form')
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
}
