/*global $*/
//画像を拡大・縮小する処理
$(document).on('turbolinks:load', function() {
  $('img.card-listImage').mouseover(function() {
    $(this).css({ transform: "scale(1.2)" })
  });
  $('img.card-listImage').mouseout(function() {
    $(this).css({ transform: "scale(1)" })
  });
});