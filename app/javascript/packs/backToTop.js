$(window).on("turbolinks:load", function(){
  $(this).scroll(function () {
    if ($(this).scrollTop() > 10) {
      $('.back-to-top').fadeIn();
    } else {
      $('.back-to-top').fadeOut();
    }
  });
  
  $('.back-to-top').click(function (e) {
    e.preventDefault()
    $('body,html').animate({
      scrollTop: 0
    }, 600);
      return false;
  });
});
