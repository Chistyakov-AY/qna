$(document).ready(function(){
  $('.answers').on('click', '.best-answer-link', function(e){
   e.preventDefault();
   $(this).hide();
   var answerId = $(this).data('answerId');
   $('form#best-answer-' + answerId).removeClass('hidden');
 })    
});