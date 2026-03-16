import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat-form"
export default class extends Controller {
  connect() {
  }

  static targets = ["input"]
  reset() {
    this.inputTarget.value = ""
    this.inputTarget.focus()
  }
}
