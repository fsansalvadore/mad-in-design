require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel';
import "bootstrap";
import { ActivePage } from './active-page';
import { cookies } from './cookies';

$(document).on('turbolinks:load', function() {

  var mySwiper = new Swiper ('.swiper-container', {
    spaceBetween: 30,
    grabCursor: true,
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
      dynamicBullets: true,
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    }
  });

  $('.owl-carousel').owlCarousel({
    stagePadding: 60,
    margin:40,
    autoplay: true,
    animateIn: true,
    loop: true,
    responsiveClass: true,
    responsive:{
      0:{
          items:1,
          nav:false
      },
      1000:{
          items:2,
          dots:false,
          loop:false
      }
     }
   })

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
    $('#mobile_menu_toggle').on('click', function() {
      $('#mobile_menu').toggleClass("menu-open");
      $(this).toggleClass("menu-anim");
    });

    $('.dark-mark').on('click', function() {
      $('body').removeClass("canvas-opened");
    });
    $('.off-canvas-close').on('click', function() {
      $('body').removeClass("canvas-opened");
    });

})(jQuery);
});

import "controllers"
