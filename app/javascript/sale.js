$(function(){
  console.log("test")
  $("#item-price").on('input', function(){
    console.log("test")
    let price = $("#item-price").val();
    if( 300 <= price && price <= 9999999) {
    let fee = Math.floor(price / 10);
    let profit = (price - fee);
    $("span#add-tax-price").text(fee);
    $("span#profit").text(profit);
    }else{
    $("span#add-tax-price").text('');
    $("span#profit").text('');
    }
  })
});