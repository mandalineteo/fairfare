import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview-image-uploaded"
export default class extends Controller {
  static targets= ["previewImage"]

  change(event) {
    const input = event.target;
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = (e) => {
          const preview = this.previewImageTarget;

          const img = new Image();
          img.src = e.target.result;
          img.style.height = "700px";
          preview.style.height = "700px";

          preview.src = img.src;
        }
        reader.readAsDataURL(input.files[0]);
    }
  }
}
