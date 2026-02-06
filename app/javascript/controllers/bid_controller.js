import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["amount", "display", "form", "error"]
  static values = { minimum: Number, current: Number }

  connect() {
    if (this.hasAmountTarget) {
      this.amountTarget.min = this.minimumValue
      this.amountTarget.value = this.minimumValue
    }
  }

  increment() {
    const step = this.currentValue >= 1000 ? 100 : this.currentValue >= 100 ? 50 : 10
    this.amountTarget.value = parseFloat(this.amountTarget.value) + step
  }

  decrement() {
    const step = this.currentValue >= 1000 ? 100 : this.currentValue >= 100 ? 50 : 10
    const newVal = parseFloat(this.amountTarget.value) - step
    if (newVal >= this.minimumValue) {
      this.amountTarget.value = newVal
    }
  }

  validate(event) {
    const amount = parseFloat(this.amountTarget.value)
    if (amount < this.minimumValue) {
      event.preventDefault()
      if (this.hasErrorTarget) {
        this.errorTarget.textContent = `Bid must be at least $${this.minimumValue.toFixed(2)}`
        this.errorTarget.classList.remove("hidden")
      }
    }
  }
}
