import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["progressBar", "message", "input", "container"];

  connect() {
    this.containerTarget.addEventListener("keyup", () => {
      this.showPasswordStrength();
    });
  }

  showPasswordStrength() {
    const password = this.inputTarget.value;
    const strength = this.calculatePasswordStrength(password);

    this.progressBarTarget.hidden = password.length === 0;
    this.messageTarget.hidden = password.length === 0;
    this.progressBarTarget.style.width = `${strength}%`;

    if (password.length >= 6) {
      this.messageTarget.innerHTML = "You can use uppercase and numbers to make your password stronger";
    } else {
      this.messageTarget.innerHTML = "Use a minimum password length of 6 or more characters";
    }
  }

  calculatePasswordStrength(password) {
    return Math.min((password.length / 12) * 100, 100);
  }
}