const CustomSlickSlider = () => {
  // Featured slider 1
  $('.featured-slider-1-items').slick({
      dots: false,
      infinite: true,
      speed: 500,
      arrows: true,
      slidesToShow: 1,
      autoplay: false,
      loop: true,
      adaptiveHeight: true,
      fade: true,
      cssEase: 'linear',
      prevArrow: '<button type="button" class="slick-prev"><i class="flaticon-left"></i></button>',
      nextArrow: '<button type="button" class="slick-next"><i class="flaticon-right"></i></button>',
      appendArrows: '.arrow-cover',
  });
  // post-carausel-1-items
  $('.post-carausel-1-items').slick({
      dots: false,
      infinite: true,
      speed: 1000,
      arrows: true,
      slidesToShow: 4,
      slidesToScroll: 1,
      autoplay: true,
      loop: true,
      adaptiveHeight: true,
      cssEase: 'linear',
      prevArrow: '<button type="button" class="slick-prev"><i class="flaticon-left"></i></button>',
      nextArrow: '<button type="button" class="slick-next"><i class="flaticon-right"></i></button>',
      appendArrows: '.post-carausel-1-arrow',
      centerPadding: 50,
      responsive: [{
              breakpoint: 1024,
              settings: {
                  slidesToShow: 4,
                  slidesToScroll: 4,
                  infinite: true,
                  dots: false,
              }
          },
          {
              breakpoint: 991,
              settings: {
                  slidesToShow: 3,
                  slidesToScroll: 3
              }
          },
          {
              breakpoint: 480,
              settings: {
                  slidesToShow: 2,
                  slidesToScroll: 2
              }
          }
      ]
  });

  // post-carausel-2
  $('.post-carausel-2').slick({
      dots: true,
      infinite: true,
      speed: 1000,
      arrows: false,
      slidesToShow: 4,
      slidesToScroll: 1,
      autoplay: false,
      loop: true,
      adaptiveHeight: true,
      cssEase: 'linear',
      centerPadding: 50,
      responsive: [{
              breakpoint: 1024,
              settings: {
                  slidesToShow: 4,
                  slidesToScroll: 4,
                  infinite: true,
                  dots: false,
              }
          },
          {
              breakpoint: 991,
              settings: {
                  slidesToShow: 3,
                  slidesToScroll: 3
              }
          },
          {
              breakpoint: 480,
              settings: {
                  slidesToShow: 1,
                  slidesToScroll: 1
              }
          }
      ]
  });

  // post-carausel-3
  $('.post-carausel-3').slick({
      dots: true,
      infinite: true,
      speed: 1000,
      arrows: false,
      slidesToShow: 4,
      slidesToScroll: 1,
      autoplay: true,
      loop: true,
      adaptiveHeight: true,
      cssEase: 'linear',
      centerPadding: 50,
      responsive: [{
              breakpoint: 1024,
              settings: {
                  slidesToShow: 4,
                  slidesToScroll: 4,
                  infinite: true,
                  dots: false,
              }
          },
          {
              breakpoint: 991,
              settings: {
                  slidesToShow: 2,
                  slidesToScroll: 1
              }
          },
          {
              breakpoint: 480,
              settings: {
                  slidesToShow: 1,
                  slidesToScroll: 1
              }
          }
      ]
  });

  $('.featured-slider-2-items').slick({
      fade: true,
      asNavFor: '.featured-slider-2-nav',
      arrows: true,
      prevArrow: '<button type="button" class="slick-prev"><i class="flaticon-left"></i></button>',
      nextArrow: '<button type="button" class="slick-next"><i class="flaticon-right"></i></button>',
      appendArrows: '.arrow-cover',
  });

  $('.featured-slider-2-nav').slick({
      slidesToShow: 4,
      slidesToScroll: 1,
      asNavFor: '.featured-slider-2-items',
      dots: false,
      arrows: false,
      centerMode: true,
      focusOnSelect: true,
      centerPadding: 0,
      responsive: [{
              breakpoint: 1024,
              settings: {
                  slidesToShow: 3,
              }
          },
          {
              breakpoint: 991,
              settings: {
                  slidesToShow: 2,
              }
          },
          {
              breakpoint: 480,
              settings: {
                  slidesToShow: 1,
              }
          }
      ]
  });
}

export { CustomSlickSlider };
