$(document).on('turbolinks:load', function () {
  $(window).on('scroll', function(){
    var more_posts_url = $('.pagination .next_page a').attr('href');
    if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 100) {
      $.getScript(more_posts_url);
    }
  });
});
