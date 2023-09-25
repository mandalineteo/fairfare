import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bills-manual-input"
export default class extends Controller {
  static targets = ["addInputElement", "removeInputElement"]

  connect() {
    this.inputField = this.addInputElementTargets[this.addInputElementTargets.length - 1].outerHTML
    this.nextId = document.querySelectorAll(".item").length
  }

  addItemInput(event) {
    // console.log("triggered")
    event.preventDefault()

    const newInput = this.buildItemInput()

    // this.addInputElementTarget.insertAdjacentHTML("beforeend", newInput)
    event.target.insertAdjacentHTML('beforebegin', newInput)
  }

  buildItemInput() {
    const currentId = this.nextId - 1
    let newInput = this.inputField.replaceAll(`_${currentId}_`, `_${this.nextId}_`)
    newInput = newInput.replaceAll(`[${currentId}]`, `[${this.nextId}]`)

    this.nextId++;

    return newInput;
  }


  removeInput(event) {
    const input = event.currentTarget.parentElement;
    const id = input.querySelector('input[id$="_id"]').value;
    let confirmDelete = false

    if (id) {
      confirmDelete = confirm('are you sure?')
    }

    // 1. choice is true && id is not nil
    if(id && confirmDelete) {
      fetch(`/items/${id}`, {
        method: 'DELETE'
      })
    }

    if(id === '' || confirmDelete)
        input.parentElement.removeChild(input)

  }
}
