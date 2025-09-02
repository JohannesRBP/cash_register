import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {

    this.autoCloseTimeout = setTimeout(() => {
      this.close();
    }, 2000);
  }

  close() {
    
    if (this.isClosing) return;
    this.isClosing = true;
    
    clearTimeout(this.autoCloseTimeout);
    
    this.element.classList.add('flash-exit');
    
    setTimeout(() => {
      this.element.remove();
    }, 300); 
  }

  disconnect() {
    clearTimeout(this.autoCloseTimeout);
  }
}