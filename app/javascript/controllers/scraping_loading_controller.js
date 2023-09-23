import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scraping-loading"
export default class extends Controller {
  static targets= ["loadingMessages"]

  connect() {
    this.i = 0;
    this.j = 0;
    this.banters = [
        "Footing the bill...",
        "Scanning the receipt...",
        "Checking item by item...",
        "Loading...",
        "Still Loading...",
        "Almost done..."
    ];
    this.speed = 100;

    this.interval = setInterval(this.typeWriter.bind(this), this.speed);
  }

  typeWriter() {
    if (this.i < this.banters.length) {
        if (this.j < this.banters[this.i].length) {
            this.loadingMessagesTarget.innerHTML += this.banters[this.i].charAt(this.j);
            this.j++;
        } else {
            this.loadingMessagesTarget.innerHTML += "<br>";
            this.i++;
            this.j = 0;
        }
    } else {
        clearInterval(this.interval);
        location.reload()
    }
  }
}
