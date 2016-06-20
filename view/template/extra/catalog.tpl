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
        <table class="list" id="tab-category-products-<?php echo $category['category_id']; ?>" class="extra-cart-content">
            <thead>
                <tr>
                    <td class="left">Название</td>
                    <td class="center">&nbsp;</td>
                    <td class="left">Количество</td>
                    <td class="right">Цена</td>
                    <td class="left">Описание</td>
                    <td class="right">Вес</td>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($category['products'] as $product) { ?>
                <tr class="product-<?php echo $product['product_id']; ?>">
                    <? /* ?><td class="category-name"><?php echo $category['name']; ?></td><? /* */ ?>
                    <td class="name left"><?php echo $product['name']; ?></td>
                    <td class="cart center">
                        <a class="button" onClick="addToCart(<?php echo $product['product_id']; ?>, $(this).parent().siblings('.quantity').find('input').val(), <?php echo $product['price']; ?>, '<?php echo $product['name']; ?>'); $('.product-<?php echo $product['product_id']; ?> .cart .button').addClass('clicked')">В корзину</a>
                    </td>
                    <td class="quantity center">
                        <span class="button-qty-minus">-</span>
                        <input size="2" type="text" name="quantity" value="1">
                        <span class="button-qty-plus">+</span>
                    </td>
                    <td class="price right"><?php echo $product['price']; ?> р.</td>
                    <td class="description left"><?php echo $product['description']; ?></td>
                    <td class="weight right"><?php echo $product['weight']; ?> г.</td>
                </tr>
            <?php } ?>
            </tbody>
        </table>
    <?php } ?>
</div>

<script type="text/javascript">
    $('#cart_tabs a').tabs();
</script>
<script type="text/javascript">
    $('#content').on('click', '.button-qty-minus, .button-qty-plus', function () {
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

        $('#cart_tabs_content .extra-cart-content > div').each(function () {
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

    $('#cart_search').on('keyup focus', 'input[name="cart_search"]', function () {
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
    $('#cart_search').on('click', '#cart_search_results > div', function (e) {
        if (e.target.nodeName == 'DIV') {
            $(this).find('.cart a').trigger('click');
        }
    });

</script>

