const ActivePage = () => {
  let url = window.location.href.split("/");
  let url_path = url[3];
  let currentNav = document.querySelector(`#navigation.main-menu a[href*='${url_path}'`);
  currentNav.classList.add("active");
}

export { ActivePage };