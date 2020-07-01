require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel';
import "bootstrap";
import { ActivePage } from './active-page';

const on_change_category = ( el ) => {
  var target = el.closest( 'fieldset' ).find( '.pub' );
  target.prop( 'checked', ( el.val() == 'cat2' ) );
  target.trigger( 'change' );
  console.log('change');
}
$(document).ready(function(){
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
            nav:true
        },
        1000:{
            items:2,
            dots:true,
            loop:false
        }
       }
     })
    });

document.addEventListener('turbolinks:load', () => {
  (function($) {
    'use strict';

    // Page loading
    $(window).on('load', function() {
        $('#preloader-active').delay(450).fadeOut('slow');
        $('body').delay(450).css({
            'overflow': 'visible'
        });
    });


    ActivePage();

    $(document).ready(function() {

    // var scrollProgress = function() {
    var docHeight = $(document).height(),
        windowHeight = $(window).height(),
        scrollPercent;
    $(window).on('scroll', function() {
        scrollPercent = $(window).scrollTop() / (docHeight - windowHeight) * 100;
        $('.scroll-progress').width(scrollPercent + '%');
    });

    // Off canvas sidebar
    // var OffCanvas = function() {
        $('#off-canvas-toggle').on('click', function() {
            $('body').toggleClass("canvas-opened");
        });

        $('.dark-mark').on('click', function() {
            $('body').removeClass("canvas-opened");
        });
        $('.off-canvas-close').on('click', function() {
            $('body').removeClass("canvas-opened");
        });
    // };
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

    // Search form
    // var openSearchForm = function() {
        $('.search-close').hide();
        $('button.search-icon').on('click', function() {
            $(this).hide();
            $('body').toggleClass("open-search-form");
            $('.search-close').show();
            $("html, body").animate({ scrollTop: 0 }, "slow");
        });
        $('.search-close').on('click', function() {
            $(this).hide();
            $('body').removeClass("open-search-form");
            $('button.search-icon').show();
        });
    // };

    });

})(jQuery);
});

import "controllers"
