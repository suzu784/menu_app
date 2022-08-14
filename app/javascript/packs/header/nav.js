/*global $*/
// ハンバーガーメニューの開閉
$(document).on('turbolinks:load', function() {
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#sp-menu').toggleClass('sp-open');
    event.preventDefault();
  });
});