$(function(){

  var keystrokes = $('#keystrokes').val() != '' ? [$('#keystrokes').val()]:[]

  $('.question').keypress(function (e) {
    keystrokes.push(String.fromCharCode(e.which));
    $('#keystrokes').val(keystrokes);
  });

});
