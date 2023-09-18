import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bills-manual-input"
export default class extends Controller {
  static targets = ["addInputElement", "taxInput"]

  connect() {
    // console.log("test");
  }

  addForm(event) {
    event.preventDefault()

    const existingItemFieldsCount = document.querySelectorAll(".item").length
    const insertForm = `<div class="item" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px">
    <div class="mb-3 string required bill_items_name" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px"><label class="form-label string required" for="bill_items_attributes_${existingItemFieldsCount}_name" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px">Name <abbr title="required" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px">*</abbr></label><input class="form-control string required" type="text" name="bill[items_attributes][${existingItemFieldsCount}][name]" id="bill_items_attributes_${existingItemFieldsCount}_name" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px"></div>
    <div class="mb-3 integer required bill_items_price" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px"><label class="form-label integer required" for="bill_items_attributes_${existingItemFieldsCount}_price" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px">Price <abbr title="required" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px">*</abbr></label><input class="form-control numeric integer required" type="number" step="1" name="bill[items_attributes][${existingItemFieldsCount}][price]" id="bill_items_attributes_${existingItemFieldsCount}_price" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px"></div>
    <div class="mb-3 integer required bill_items_quantity" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px"><label class="form-label integer required" for="bill_items_attributes_${existingItemFieldsCount}_quantity" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px">Quantity <abbr title="required" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px">*</abbr></label><input class="form-control numeric integer required" type="number" step="1" name="bill[items_attributes][${existingItemFieldsCount}][quantity]" id="bill_items_attributes_${existingItemFieldsCount}_quantity" speechify-initial-font-family="&quot;Work Sans&quot;, Helvetica, &quot;sans-serif&quot;" speechify-initial-font-size="16px"></div>
    </div>`

    this.addInputElementTarget.insertAdjacentHTML("beforeend", insertForm)
  }

  addTax(event) {
    event.preventDefault()
  }

}
