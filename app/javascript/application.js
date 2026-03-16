import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener("turbo:load", () => {
  const messages = document.getElementById("messages")

  if (messages) {
    messages.scrollIntoView({ behavior: "smooth", block: "end" })
  }

  document.querySelectorAll(".quicktrip-flash-close").forEach((button) => {
    button.addEventListener("click", () => {
      button.closest(".quicktrip-flash")?.remove()
    })
  })

  setTimeout(() => {
    document.querySelectorAll(".quicktrip-flash").forEach((flash) => {
      flash.remove()
    })
  }, 3500)
})
