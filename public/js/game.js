$(document).ready(function(){
  $.ajax({
    url: window.location.pathname + "/board",
    method: "put",
    data: {current_board: $(".board").html()}
  });

  function getUpdatedBoard() {
    console.log('XXX');
    $.ajax({
      type: 'get',
      url: window.location.pathname + "/board"
    }).done(function(response) {
      if (response !== "nil") {
        $(".board").html(response);
      }
    });
    checkWinner();
  };

  function freeze() {
    $('body').append("<p class='freeze'>game over</p>");
    debugger;      
  }

  var checkWinner = function() {
    var sq = [];
    $('.square').each(function(e,x) {
      sq.push($(x).text());
    });
    var row1 = sq[0] + sq[1] + sq[2];
    var row2 = sq[3] + sq[4] + sq[5];
    var row3 = sq[6] + sq[7] + sq[8];
    var col1 = sq[0] + sq[3] + sq[6];
    var col2 = sq[1] + sq[4] + sq[7];
    var col3 = sq[2] + sq[5] + sq[8];
    var diag1 = sq[0] + sq[4] + sq[8];
    var diag2 = sq[2] + sq[4] + sq[6];
    var rows = [row1, row2, row3];
    var cols = [col1, col2, col3];
    var diags = [diag1, diag2];

    if (rows.indexOf('XXX') != -1 || cols.indexOf('XXX') != -1 || diags.indexOf('XXX') != -1 ) {
      var creator = $('.creator').attr('value');
      clearInterval(getBoard);
      alert(creator + " WINS!");
      freeze();
    } else if (rows.indexOf('OOO') != -1 || cols.indexOf('OOO') != -1 || diags.indexOf('OOO') != -1) {
      var joined = $('.joined').attr('value');
      clearInterval(getBoard);
      alert(joined + " WINS!");
      freeze();
    }
  }

  $(".board").on("click", '.square', function(){
    if($(this).text() != "" || $('.freeze').text() == 'game over') {
      console.log('woo');
      return;
    }
    var that = this;
    $.ajax({
      url: window.location.pathname + "/turn",
      method:"get"
    }).done(function(response){
      if (response!=="false") {
        $(that).html(response);
        $.ajax({
          url: window.location.pathname + "/board",
          method: "put",
          data: {current_board: $(".board").html()}
        });
      }
    });
  });
  getBoard = setInterval(getUpdatedBoard, 2000);
});