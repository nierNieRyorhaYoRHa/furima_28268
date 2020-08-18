function sale() {
  const price = document.getElementById("item-price");
  price.addEventListener("oninput", (e) => {

  })

}
setInterval(check, 1000);


$(function(){
  $("#item_price").on('keyup', function(){
    var price = $("#item_price").val();
    if( 300 <= price && price <= 9999999) {
    var fee = Math.floor(price / 10);
    var profit = (price - fee);
    $(".fee-span").text(fee);
    $(".profit-span").text(profit);
    }else{
    $(".fee-span").text('');
    $(".profit-span").text('');
    }
  })
});