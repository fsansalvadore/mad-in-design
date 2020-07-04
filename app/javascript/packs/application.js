require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel';
import "bootstrap";
import { ActivePage } from './active-page';
import { cookies } from './cookies';
import { SwiperSnippet } from './swiper';
import { MobileMenuToggle } from './mobile-menu-toggle';

$(document).on('turbolinks:load', function() {

  SwiperSnippet();
  cookies();
  ActivePage();

  (function($) {
    'use strict';

    // Page loading
    $(window).on('load', function() {
      $('#preloader-active').delay(450).fadeOut('slow');
      $('body').delay(450).css({
          'overflow': 'visible'
      });
    });

    // Scroll Progress
    var docHeight = $(document).height(),
        windowHeight = $(window).height(),
        scrollPercent;
    $(window).on('scroll', function() {
        scrollPercent = $(window).scrollTop() / (docHeight - windowHeight) * 100;
        $('.scroll-progress').width(scrollPercent + '%');
    });

    // Menu toggle
    MobileMenuToggle();

})(jQuery);
});

import "controllers"
