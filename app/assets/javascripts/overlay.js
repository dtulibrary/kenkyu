function ($) {

  $("#overlay").click(function () {
    // Add modal background
    $('body').append('<div id="overlay"></div>');
       $("#overlay").fadeIn();
   
  });

})(jQuery);
