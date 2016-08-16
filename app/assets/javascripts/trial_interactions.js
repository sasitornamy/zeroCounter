$(function(){

  var keystrokes = [];

  $('.question').keypress(function (e) {
    keystrokes.push(String.fromCharCode(e.which));
    $('#keystrokes').val(keystrokes);
  });

});
