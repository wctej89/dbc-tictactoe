setInterval(function getUpdatedBoard() {
  $.ajax({
    type: 'get',
    url: window.location.pathname + "/board"
  }).done(function(response) {
    if (response !== "nil") {
      setTimeout(function(){
        $(".board").html(response);
        getUpdatedBoard();
      }, 500);
    }
  });
}, 10000);


$(document).ready(function(){
  $.ajax({
          url: window.location.pathname + "/board",
          method: "put",
          data: {current_board: $(".board").html()}
        });

  var board = {
    0: null,
    1: null,
    2: null,
    3: null,
    4: null,
    5: null,
    6: null,
    7: null,
    8: null
  };

  $(".square").on("click", function(){
    var that = this;
    $.ajax({
      url: window.location.pathname + "/turn",
      method:"get"
    }).done(function(response){
      if (response!=="false") {
        console.log($(".board").html());
        $(that).html(response);
        $.ajax({
          url: window.location.pathname + "/board",
          method: "put",
          data: {current_board: $(".board").html()}
        });
      }
    });
  });

  setTimeout(getUpdatedBoard(), 10000);

// PROBLEMS: board is nested*FIXED*; default value in DB is weird and fucked up

});