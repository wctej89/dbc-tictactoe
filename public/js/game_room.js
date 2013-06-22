function getOpponentStatus() {
  $.ajax({
    type: 'get',
    url: window.location.pathname + "/opponent"
  }).done(function(response) {
    if (response === "nil") {
      setTimeout(function(){
        getOpponentStatus();
      }, 500);
    } else {
      $("#opponent_name").html(response);
    }
  });
}

$(document).ready(function() {
  getOpponentStatus();
});