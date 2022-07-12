/*global $*/
$(function(){
  function buildField(index) {
    const html = `<div class="js-file-group" data-index="${index}">
                    <div class="tag-area__form">
                      <input type="text" name="recipe[tags_attributes][${index}][content]" id="recipe_tags_attributes_${index}_content">
                      <span class="delete-form-btn">
                        削除
                      </span>
                    </div>
                  </div>`;
    return html;
  }

  let fileIndex = [1, 2, 3]
  var lastIndex = $(".js-file-group:last").data("index");
  fileIndex.splice(0, lastIndex);
  let fileCount = $(".hidden-destroy").length;
  let displayCount = $(".js-file-group").length
  $(".hidden-destroy").hide();
  if (fileIndex.length == 0) $(".add-form-btn").css("display","none");

  $(".add-form-btn").on("click", function() {
    $(".tag-area").append(buildField(fileIndex[0]));
    fileIndex.shift();
    if (fileIndex.length == 0) $(".add-form-btn").css("display","none");
    displayCount += 1;
  })

  $(".tag-area").on("click", ".delete-form-btn", function() {
    $(".add-form-btn").css("display","block");
    const targetIndex = $(this).parent().parent().data("index")
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    var lastIndex = $(".js-file-group:last").data("index");
    displayCount -= 1;
    if (targetIndex < fileCount) {
      $(this).parent().parent().css("display","none")
      hiddenCheck.prop("checked", true);
    } else {
      $(this).parent().parent().remove();
    }
    if (fileIndex.length >= 1) {
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    } else {
      fileIndex.push(lastIndex + 1);
    }
    if (displayCount == 0) {
      $(".tag-area").append(buildField(fileIndex[0] - 1));
      fileIndex.shift();
      displayCount += 1;
    }
  })
})