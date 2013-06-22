var theResponse = "nil";

function getOpponentStatus() {
  console.log("Starting AJAX call.");
  $.ajax({
    type: 'get',
    url: window.location.pathname + "/opponent"
  }).done(function(response) {
    console.log("Finished AJAX call.");
    if (response === "nil") {
      setTimeout(function(){
        console.log("polling");
        getOpponentStatus();
      }, 500);
    } else {
      console.log(response);
      $("#opponent_name").html(response);
    }
  });
}

$(document).ready(function() {
  console.log("Hello.");
  getOpponentStatus();
});