/*global $*/
// ボタンを押した後に最上部に時間をかけて移動する処理
$(document).on('turbolinks:load', function() {
  $('#back a').on('click', function(event) {
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});