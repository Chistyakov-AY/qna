import { Application } from "@hotwired/stimulus"
// import * as ActiveStorage from '@rails/activestorage'

const application = Application.start()
// ActiveStorage.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

//import Rails from '@rails/ujs';

//Rails.start();