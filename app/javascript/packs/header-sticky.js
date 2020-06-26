const HeaderStickySnippet = () => {
  $(window).on('scroll', function() {
      var scroll = $(window).scrollTop();
      if (scroll < 245) {
          $(".header-sticky ").removeClass("sticky-bar");
      } else {
          $(".header-sticky").addClass("sticky-bar");
      }
  })
};

export { HeaderStickySnippet };
