window.addEventListener('load', function() {
  let selectInputs = document.querySelectorAll('.admin_projects .project_content_sections .has_many_fields ol li.selectInput select');
  selectInputs.forEach(function(sel){
      checkSelectionValue(sel);
    });
  })

function removeShow(e, selector) {
  e.parentElement.parentElement.querySelectorAll(selector).forEach(function(i) {
    i.classList.remove("showInput");
  })
}

function addShow(e, selector) {
  e.parentElement.parentElement.querySelectorAll(selector).forEach(function(i) {
    i.classList.add("showInput");
  })
}

function checkSelectionValue(e) {
  if (e.value == 0) {
    removeShow(e, ".typ2");
    removeShow(e, ".typ3");
    addShow(e, ".typ1");
  } else if (e.value == 1) {
    removeShow(e, ".typ1");
    removeShow(e, ".typ3");
    addShow(e, ".typ2");
  } else if (e.value == 2) {
    removeShow(e, ".typ1");
    removeShow(e, ".typ2");
    addShow(e, ".typ3");
  }
}

function selectChange(e) {
  checkSelectionValue(e);
}
