<div id="cart_tabs" class="htabs">
  <?php foreach ($categories as $category) { ?>
  <a href="#tab-category-products-<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></a>
  <?php } ?>
  <div id="cart_search">
    <input type="text" name="cart_search" value="">
    <input type="button" name="submit_cart_search" value="OK">
    <div id="cart_search_results" class="extra-cart-content"></div>
  </div>
</div>
<div class="">&nbsp;</div>
<div id="cart_tabs_content"> 
<?php foreach ($categories as $category) { ?>
<div id="tab-category-products-<?php echo $category['category_id']; ?>" class="extra-cart-content">
    <div class="thead">
      <div class="category-name">Категория</div>
      <div class="name">Названия</div>
      <div class="cart">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      </div>
      <div class="quantity">Количество</div>
      <div class="price">Цена</div>
      <div class="description">Описание</div>
      <div class="weight">Вес</div>
    </div>
  <?php foreach ($category['products'] as $product) { ?>
    <div class="product-<?php echo $product['product_id']; ?>">
      <div class="category-name"><?php echo $category['name']; ?></div>
      <div class="name"><?php echo $product['name']; ?></div>
      <div class="cart">
        <a class="button" onClick="addToCart(<?php echo $product['product_id']; ?>, $(this).parent().siblings('.quantity').find('input').val(), <?php echo $product['price']; ?>, '<?php echo $product['name']; ?>'); $('.product-<?php echo $product['product_id']; ?> .cart .button').addClass('clicked')">В корзину</a>
      </div>
      <div class="quantity">
        <span class="button-qty-minus">-</span>
        <input size="2" type="text" name="quantity" value="1">
        <span class="button-qty-plus">+</span>
      </div>
      <div class="price"><?php echo $product['price']; ?> р.</div>
      <div class="description"><?php echo $product['description']; ?></div>
      <div class="weight"><?php echo $product['weight']; ?> г.</div>
    </div>
  <?php } ?>
</div>
<?php } ?>
</div>

<script type="text/javascript">
$('#cart_tabs a').tabs();
</script>
<script type="text/javascript">
$('#content').on('click', '.button-qty-minus, .button-qty-plus', function() {
  var qty = $(this).siblings('input');
  var quantity = $(qty).val().replace(/[^0-9\.]+/g, '');
  
  if ($(this).hasClass('button-qty-minus')) {
    quantity--;
  } else {
    quantity++;
  }
  
  if (quantity < 1) {
    quantity = 1;
  }
  
  $(qty).val(quantity);
  
  calcExtraOrder();
});
</script>
<script type="text/javascript">
function autoCompleteCartSearch(word) {
  var name = '';
  var html = '';

  $('#cart_tabs_content .extra-cart-content > div').each(function() {
    name = $(this).find('.name').text();
    desc = $(this).find('.description').text();
    
    if (name.toLowerCase().indexOf(word.toLowerCase()) >= 0 || desc.toLowerCase().indexOf(word.toLowerCase()) >= 0) {
      $(this).find('.quantity input').val(1);
      html += $(this).wrap('<p/>').parent().html();
      $(this).unwrap();
    }
  });
  
  if (html.length) {
    $('#cart_search_results').html(html);
    $('#cart_search_results').css('display', 'block');
  } else {
    $('#cart_search_results').css('display', 'none');
  }
}

$('#cart_search').on('keyup focus', 'input[name="cart_search"]', function() {
  var word = $.trim($(this).val());
  if (word.length > 1) {
    autoCompleteCartSearch(word);
  }
});

$(document).mouseup(function (e) {
  var container = $('#cart_search');

  if (!container.is(e.target) && container.has(e.target).length === 0) {
    $('#cart_search_results').css('display', 'none');
  }
});

// Добавление в корзину при клике на результат поиска
$('#cart_search').on('click', '#cart_search_results > div', function(e) {
  if (e.target.nodeName == 'DIV') {
    $(this).find('.cart a').trigger('click');
  }
});

</script>

