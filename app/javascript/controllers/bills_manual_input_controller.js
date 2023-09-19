import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bills-manual-input"
export default class extends Controller {
  static targets = ["addInputElement", "removeInputElement"]
  // static values = {
  //   input: String
  // }

  connect() {
    this.inputField = this.addInputElementTarget.children[0].outerHTML
    this.nextId = document.querySelectorAll(".item").length
  }

  addItemInput(event) {
    // console.log("triggered")
    event.preventDefault()

    const newInput = this.buildItemInput()

    this.addInputElementTarget.insertAdjacentHTML("beforeend", newInput)
  }

  buildItemInput() {
    let newInput = this.inputField.replaceAll('_0_', `_${this.nextId}_`)
    newInput = newInput.replaceAll('[0]', `[${this.nextId}]`)

    this.nextId++;

    return newInput;
  }


  removeInput(event) {
    const input = event.target.parentElement;
    input.parentElement.removeChild(input)
  }
}
