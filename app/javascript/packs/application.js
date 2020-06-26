require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


import "bootstrap";

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

    // Mobile menu
    // var mobileMenu = function() {
        var menu = $('ul#navigation');
        if (menu.length) {
            menu.slicknav({
                prependTo: ".mobile_menu",
                closedSymbol: '+',
                openedSymbol: '-'
            });
        };
    // };

    });

})(jQuery);
});
