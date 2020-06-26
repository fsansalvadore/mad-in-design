const OffCanvasSidebar = () => {
  $('#off-canvas-toggle').on('click', function() {
      $('body').toggleClass("canvas-opened");
  });

  $('.dark-mark').on('click', function() {
      $('body').removeClass("canvas-opened");
  });
  $('.off-canvas-close').on('click', function() {
      $('body').removeClass("canvas-opened");
  });
}

export { OffCanvasSidebar };
