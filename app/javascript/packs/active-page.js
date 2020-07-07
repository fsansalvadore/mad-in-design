const ActivePage = () => {
  let url = window.location.href.split("/");
  let url_path = url[3].split("?")[0];
  let currentNav = "";
  if (url_path === "") {
    currentNav = document.querySelector(`#navigation.main-menu a[href='/'`);
  } else {
    currentNav = document.querySelector(`#navigation.main-menu a[href*='${url_path}'`);
  }
  currentNav.classList.add("active");
}

export { ActivePage };
