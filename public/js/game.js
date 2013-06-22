$(document).ready(function(){

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
    console.log("here");
    $.ajax({
      url: window.location.pathname + "/turn",
      method:"get"
    }).done(function(response){
      console.log(response);
      if (response!=="false") {
        console.log(that);
        $(that).html(response);
      }
    });
  });
});