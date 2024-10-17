# frozen_string_literal: true

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: false
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true

# pin 'jquery', to: 'jquery.min.js', preload: true
# pin 'jquery_ujs', to: 'jquery_ujs.js', preload: true

pin '@rails/ujs', to: 'https://ga.jspm.io/npm:@rails/ujs@7.1.2/app/assets/javascripts/rails-ujs.esm.js'
pin 'jquery', to: 'https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin '@rails/activestorage', to: 'https://ga.jspm.io/npm:@rails/activestorage@7.1.2/app/assets/javascripts/activestorage.esm.js'
