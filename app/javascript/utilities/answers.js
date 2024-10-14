$(document).on('turbolinks:load', function(){
  console.log('Hello! I am a message from answers.js!')
  $('.answers').on('click', '.edit-answer-link',  function(event){
    event.preventDefault();
    $(this).hide();
    var answerId = $(this).data('answerId');
    $('form#edit-answer-' + answerId).removeClass('hidden');
  }) 
});
