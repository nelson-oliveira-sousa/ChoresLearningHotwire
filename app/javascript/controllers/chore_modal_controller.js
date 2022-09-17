import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chore-modal"
export default class extends Controller {
  static targets = ["form"] 

  hideModal() {
    this.element.parentElement.removeAttribute("src")
    this.element.remove()
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal
    }
  }

  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.hideModal()
    }
  }

  // hide modal when clicking outside of modal
  // action: "click@window->chore-modal#closeBackground"
  closeBackground(e) {
    if (e && this.formTarget.contains(e.target)) { // check with user are clicking inside the form
      return
    }
    this.hideModal()
  }
}
