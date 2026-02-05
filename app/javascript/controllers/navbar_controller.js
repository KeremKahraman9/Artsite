import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "toggle"]

  connect() {
    this.scrollHandler = () => this.handleScroll()
    window.addEventListener("scroll", this.scrollHandler)
  }

  disconnect() {
    window.removeEventListener("scroll", this.scrollHandler)
  }

  toggleMenu() {
    if (this.hasMenuTarget) {
      this.menuTarget.classList.toggle("open")
    }
    if (this.hasToggleTarget) {
      this.toggleTarget.classList.toggle("active")
    }
  }

  handleScroll() {
    if (window.scrollY > 50) {
      this.element.classList.add("scrolled")
    } else {
      this.element.classList.remove("scrolled")
    }
  }
}
