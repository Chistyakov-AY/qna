// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import * as ActiveStorage from '@rails/activestorage'
ActiveStorage.start()
console.log("ActiveStorage2")

import Rails from '@rails/ujs';
Rails.start();
console.log("Rails")

import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

console.log("jquery")

import "@hotwired/turbo-rails"
import "controllers"

$(document).ready(function(){
  $('.answers').on('click', '.edit-answer-link', function(e){
    e.preventDefault();
    $(this).hide();
    var answerId = $(this).data('answerId');
    $('.delete_file_' + answerId).removeClass('hidden');
    $('form#edit-answer-' + answerId).removeClass('hidden');
  })
});

$(document).ready(function(){
  $('.answers').on('click', '.best-answer-link', function(e){
    e.preventDefault();
    $(this).hide();
    var answerId = $(this).data('answerId');
    $('form#best-answer-' + answerId).removeClass('hidden');
  })
});

$(document).ready(function(){
  $('.question').on('click', '.edit-question-link', function(e){
    e.preventDefault();
    $(this).hide();
    var questionId = $(this).data('questionId');
    $('form#edit-question-' + questionId).removeClass('hidden');
    $('.delete_file_' + questionId).removeClass('hidden');
  })
});

// import "@hotwired/turbo-rails"
// import "controllers"
// import "./add_jquery"
// import "jquery"
// import "jquery_ujs"
// import "./answers"
// import "./questions"
// import "./best"

// import Rails from "@rails/ujs";
// Rails.start(); 
