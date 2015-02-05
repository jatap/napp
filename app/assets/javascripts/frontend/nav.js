var $window = $(window);

function stickNav() {

    var infoHeight = $('header.top .info').height();
    var navheight  = $('header.navigation nav').height();
    var scrollTop  = $window.scrollTop();

    if (scrollTop > (navheight + infoHeight)) {
        $('header.navigation').addClass('sticky');
    } else {
        $('header.navigation').removeClass('sticky');
    }
}

function navToggle() {

  var menuToggle = $('#js-mobile-menu').unbind();
  $('#js-navigation-menu').removeClass("show");

  menuToggle.on('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    $('#js-navigation-menu').slideToggle(function(){
      if($('#js-navigation-menu').is(':hidden')) {
        $('#js-navigation-menu').removeAttr('style');
      }
    });
  });

}

$(document).ready(function() {

  navToggle();

  var window = $(window);

  $window.on('touchmove', stickNav);
  $window.on('scroll', stickNav);

});
