// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

 document.addEventListener("turbo:load", () => {
  window.scrollTo(0, document.body.scrollHeight)
})
