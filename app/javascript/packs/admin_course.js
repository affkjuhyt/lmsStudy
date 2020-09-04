var lesson_box;

$(window).on("turbolinks:load", function(){
  $( "#sortable" ).sortable();
  $( "#sortable" ).disableSelection();
  if ($("#sortable .lesson-box").length == 1) {
    $(".remove-lesson").hide();
  }
  lesson_box = $("#sortable .lesson-box").first().html();
});

$(document).on("click", ".btn-add-lesson", function() {
  new_box = $(lesson_box);
  addLesson(new_box);
});

$(document).on("click", ".remove-lesson", function() {
  parent = $(this).closest("#sortable");
  number_lesson = $("#sortable .lesson-box").length;
  replaceLesson($("input[name^='course[lessons_attributes][" + (number_lesson - 1) + "']"),
    $(this).closest(".lesson-box").find(".input-video-url") )
  $(this).closest(".lesson-box").remove();
  if (parent.find(".lesson-box").length == 1) {
    parent.find(".remove-lesson").hide();
  }
  $(this).closest(".lesson-box").remove();
});

$(document).on("click", ".btn-submit-course", function () {
  $("#sortable").find(".lesson-box").each(function (index) {
    $(this).find(".lesson_seq").val(index + 1);
  })
  $(".form-course").submit()
})

function change_name_lesson(lesson, number_lesson) {
  lesson.find("input").each(function () {
    if ($(this).attr("name").includes("course[lessons_attributes]")) {
      $(this).attr("name", $(this).attr("name").replace($(this).attr("name").substring(0,$(this).attr("name").indexOf(']', 26)),
      "course[lessons_attributes][" + number_lesson));
    }
  })
  lesson = lesson.html();
}

function addLesson(new_box) {
  var number_lesson = $("#sortable .lesson-box").length;
  var parent = "<div class='lesson-box lesson-field ui-sortable-handle'></div>"
  new_box.find(".lesson_seq").val(number_lesson +1);
  change_name_lesson(new_box, number_lesson, 0, 0);
  $("#sortable").append(parent);
  $("#sortable .lesson-box").last().append(new_box);
  $(".remove-lesson").show();
}
