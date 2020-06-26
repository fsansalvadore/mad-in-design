const MegaMenuSnippet = () => {
  $('.sub-mega-menu .nav-pills > a').on('mouseover', function(event) {
      $(this).tab('show');
  });
}

export { MegaMenuSnippet };
