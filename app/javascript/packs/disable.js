$(document).on("change", ".radio-lesson-type", function () {
  let inputVideo = $(this).closest(".card").find(".input-video-url");
  let questionForm = $(this).closest(".card").find(".quiz-form");
  let inputPoint = $(this).closest(".card").find(".input-min-point");
  if ($(this).val() == "question") {
    inputVideo.prop("disabled", true);
    inputVideo.val("");
    inputPoint.prop("disabled", false);
    if ($(this).closest(".card").find(".input-lesson-name").is(":visible")) {
      questionForm.show();
    }
  } else if($(this).val() == "video"){
    inputVideo.prop("disabled", false);
    inputPoint.prop("disabled", true);
    inputPoint.val("");
    questionForm.find("input").each(function () {
      $(this).val("");
    })
    questionForm.hide();
  }
});

$(window).on("turbolinks:load", function () {
  $(document).find(".quiz-form").hide();
  var items_locked = $(".lesson-locked .lesson-item")
  items_locked.prop("disabled", true);
  $(".radio-lesson-type").each(function () {
    if ($(this).closest(".card-header").find(".quiz").is(":checked")) {
      $(this).closest(".card").find(".input-video-url").prop("disabled", true);
    } else{
      $(this).closest(".card").find(".input-min-point").prop("disabled", true);
    }
  });
});
