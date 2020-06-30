window.addEventListener('load', function() {
  let selectInput = document.querySelector('.admin_projects .project_content_sections .has_many_fields ol li select');
  selectInput.addEventListener('click', function(e) {
    alert("change");
  });

})


function selectChange(e) {
  // alert(e.parentElement.parentElement.querySelector(".typ2"));
  if (e.value == 0) {
    e.parentElement.parentElement.querySelectorAll(".typ2").forEach(function(i) {
      i.classList.remove("showInput");
    })
    e.parentElement.parentElement.querySelectorAll(".typ3").forEach(function(i) {
      i.classList.remove("showInput");
    })
    e.parentElement.parentElement.querySelectorAll(".typ1").forEach(function(i) {
      i.classList.add("showInput");
    })
  } else if (e.value == 1) {
    e.parentElement.parentElement.querySelectorAll(".typ1").forEach(function(i) {
      i.classList.remove("showInput");
    })
    e.parentElement.parentElement.querySelectorAll(".typ3").forEach(function(i) {
      i.classList.remove("showInput");
    })
    e.parentElement.parentElement.querySelectorAll(".typ2").forEach(function(i) {
      i.classList.add("showInput");
    })
  } else if (e.value == 2) {
    e.parentElement.parentElement.querySelectorAll(".typ1").forEach(function(i) {
      i.classList.remove("showInput");
    })
    e.parentElement.parentElement.querySelectorAll(".typ2").forEach(function(i) {
      i.classList.remove("showInput");
    })
    e.parentElement.parentElement.querySelectorAll(".typ3").forEach(function(i) {
      i.classList.add("showInput");
    })
  }
}
