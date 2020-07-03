const MobileMenuToggle = () => {
  $('#mobile_menu_toggle').on('click', function() {
    $('#mobile_menu').toggleClass("menu-open");
    $(this).toggleClass("icon-anim");
  });
}

export { MobileMenuToggle };
