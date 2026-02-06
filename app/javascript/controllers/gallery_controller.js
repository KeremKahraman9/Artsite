import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]

  connect() {
    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("visible")
            this.observer.unobserve(entry.target)
          }
        })
      },
      { threshold: 0.1 }
    )

    this.itemTargets.forEach((item) => this.observer.observe(item))
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }
}
