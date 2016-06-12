<?php echo $header; ?>
<div id="content">
    <form id="extra_order_form" action="" method="POST">
        <div class="box">
            <?php if ($extra_comment) { ?>
                <div class="extra-comment"><?php echo $extra_comment; ?></div>
            <?php } ?>
            <div class="heading">
                <h1><img src="view/image/category.png" alt="" />Обработка заявки
                    <?php if ($customer) { ?>
                        <span class="customer">(<?php echo $customer['name']; ?> 8<?php echo $customer['phone']; ?>;
                            время доставки: <?php echo $config_delivery_time; ?>
                            )</span>
                    <?php } ?>
                </h1>
            </div>
            <?php if ($latest_orders) { ?>
                <div class="content auto-height">
                    <!-- заказы от пользователя в процессе -->
                    <h2>Текущие заказы</h2>
                    <table class="list" id="orders_in_process">
                        <thead>
                            <tr>
                                <td>Дата</td>
                                <td>Время приема</td>
                                <td>Время доставки</td>
                                <td>Осталось</td>
                                <td>Сумма заказа</td>
                                <td>Статус</td>
                                <td></td>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($latest_orders as $order) { ?>
                                <tr>
                                    <td><?php echo $order['date_delivery']; ?></td>
                                    <td><?php echo $order['time_confirm']; ?></td>
                                    <td><?php echo $order['time_delivery']; ?></td>
                                    <td>
                                        <?php echo $order['text_time_left']; ?>
                                    </td>
                                    <td><?php echo $order['total_special']; ?>р.</td>
                                    <td><?php echo $order['status_name']; ?></td>
                                    <td><a class="dotted" onClick="cancelOrder(<?php echo $order['order_id']; ?>)"><span>Отменить</span></td>
                                </tr>
                            <?php } ?>
                        </tbody>
                    </table>
                </div>
            <?php } ?>
            <div class="content auto-height">
                <h2>Новый заказ</h2>
                <?php echo $catalog; ?>
                <?php echo $order_info; ?>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    function getDeliveryPrice() {
        var m = parseFloat($('#delivery_info input[name="customer[distance]"]').val());
        //m *= 1000;
        if (m < 6000) {
            return 100;
        } else if (m < 10300) {
            return 150;
        } else if (m < 12200) {
            return 200;
        } else if (m < 16100) {
            return 250;
        } else if (m < 19100) {
            return 300;
        } else {
            return 400;
        }
    }

    function isNumber(n) {
        return !isNaN(parseFloat(n)) && isFinite(n);
    }

    function calcExtraOrder() {
        total = 0;
        total_special = 0;

        var fieldWithdraw = "";
        var inputWithdraw = $("[name=bonus_withdraw]");
        var inputFill = $("[name=bonus_fill]");

        var fill = 0;
        var withdraw = 0;
        var deltaTotal = 0;

        $('#extra_order_cart tbody tr').each(function () {
            global_special_percent = parseInt($('#extra_order_cart thead select[name="customer[total_special]"]').val());
            var bonusField = $(this).find(".eo-product-bonuspoints");
            var bonusFilled = 0;
            var delta = 0;

            price = $(this).find('.eo-input-product-price').val();
            quantity = $(this).find('.quantity input').val();
            special_percent = parseInt($(this).find('.eo-product-special_percent option:selected').val());

            bonusFilled = price * quantity * (special_percent ? 0.01 : 0.02);
            delta = bonusFilled - Math.floor(bonusFilled);
            bonusField.html(Math.floor(bonusFilled));
            deltaTotal += delta;
            fill += Math.floor(bonusFilled);

            if (special_percent < global_special_percent) {
                $(this).find('.eo-product-special_percent select').val(global_special_percent);
                special_percent = global_special_percent;
            }

            special = price - (price / 100 * special_percent);
            product_total = price * quantity;
            product_total_special = special * quantity;

            // inputs
            $(this).find('.eo-input-product-special').val(special);
            $(this).find('.eo-input-product-total').val(product_total);

            // html
            $(this).find('.eo-product-special').html(special);
            $(this).find('.eo-product-total').html(product_total_special);

            // global
            total += parseFloat(product_total);
            total_special += parseFloat(product_total_special);
        });

        var biglion = $('#extra_order_info input[name="order[biglion]"]:checked').val();
        var delivery_method = parseInt($('#extra_order_info input[name="order[delivery_id]"]:checked').val());
        var free_delivery_methods = [<?php echo implode(',', $free_delivery_ids); ?>];
        var m = parseInt($('#clientcard input[name="customer[distance]"]').val());

        if ((!delivery_method || $.inArray(delivery_method, free_delivery_methods) < 0) && (m > <?php echo FREE_DELIVERY_DISTANCE; ?> || biglion || (total_special > 0 && total_special < <?php echo FREE_DELIVERY_TOTAL; ?>))) {
            var delivery_price = getDeliveryPrice();
        } else {
            var delivery_price = 0;
        }


        if (total > 0) {
            special_percent = ((total - total_special) / (total / 100)).toFixed(1);
        } else {
            special_percent = 0;
        }

        order_info = $('#extra_total_info');
        order_info.find('.eo-order-total_price').html(total);
        order_info.find('.eo-order-total_special').html(total_special);
        order_info.find('.eo-order-special_percent').html(special_percent);
        order_info.find('.eo-order-delivery').html(delivery_price);
        order_info.find('.eo-order-total').html(total_special + delivery_price);

        inputFill.val(fill);
    }


    function getSpecialsHtml(product_id, selected) {
        var html = '';
        html += '<select name="products[' + product_id + '][special_percent]">';
<?php foreach ($specials as $special) { ?>
            html += '<option value="<?php echo $special; ?>"><?php echo $special; ?>%</option>';
<?php } ?>
        html += '</select>';

        if (selected) {
            select_obj = $('<div/>').html(html).contents();

            $(select_obj).find('option[value="' + selected + '"]').attr('selected', 'selected');

            html = $(select_obj).prop('outerHTML');
        }

        return html;
    }

    function addToCart(product_id, quantity, price, name) {
        if ($('#extra_order_cart #eo-row-' + product_id).length) {
            // уже есть в корзине, просто увеличиваем кол-во
            qty_input = $('#extra_order_cart #eo-row-' + product_id + ' .quantity input');
            qty_val = parseFloat($(qty_input).val()) + parseFloat(quantity);

            $(qty_input).val(qty_val);

        } else {
            number = $('#extra_order_cart tbody tr').length + 1;

            // формируем html товара в корзине
            var html = '';
            html += '<tr id="eo-row-' + product_id + '">';
            html += '	<td>' + number;
            html += '	  <div style="display: none" class="hidden-inputs">';
            html += '    <input type="hidden" value="' + product_id + '" name="products[' + product_id + '][product_id]" class="eo-input-product-product_id">';
            html += '     <input type="hidden" value="' + price + '" name="products[' + product_id + '][price]" class="eo-input-product-price">';
            html += '     <input type="hidden" value="0" name="products[' + product_id + '][special]" class="eo-input-product-special">';
            html += '     <input type="hidden" value="0" name="products[' + product_id + '][total]" class="eo-input-product-total">';
            html += '   </div>';
            html += ' </td>';
            html += ' <td class="eo-product-name">' + name + '</td>';
            html += ' <td class="eo-product-quantity">';
            html += '   <div class="quantity">';
            html += '     <span class="button-qty-minus">-</span>';
            html += '     <input type="text" value="' + quantity + '" name="products[' + product_id + '][quantity]" size="2">';
            html += '     <span class="button-qty-plus">+</span>';
            html += '   </div>';
            html += ' </td>';
            html += ' <td class="eo-product-price">' + price + '</td>';
            html += ' <td class="eo-product-special_percent">';

            selected = $('#extra_order_info select[name="customer[total_special]"]').val();
            html += getSpecialsHtml(product_id, selected);

            var points = 0;
            html += ' <td class="eo-product-bonuspoints">' + Math.floor(points) + '</td>';

            html += ' </td>';
            html += ' <td class="eo-product-special">0</td>';
            html += ' <td class="eo-product-total">0</td>';
            html += ' <td><a onclick="removeFromCart(' + product_id + ')">x</a></td>';
            html += '</tr>';

            $('#extra_order_cart tbody').append(html);

        }
        calcExtraOrder();
    }

    function removeFromCart(product_id) {
        $('#eo-row-' + product_id).remove();
        calcExtraOrder();
    }

    $(function () {
        $('#content').on('change', 'select[name="customer[total_special]"]', function () {
            val = $(this).val()


            $('#content').find('select[name="customer[total_special]"]').val(val);

            calcExtraOrder();
        });

        $('#content').on('change', '.eo-product-special_percent select, input[name="order[biglion]"], #extra_order_info input[name="order[delivery_id]"]', function () {
            calcExtraOrder();
        });

        $('#content').on('change', '.quantity input', function () {
            if (!isNumber($(this).val())) {
                $(this).val(1);
            }

            if ($(this).closest('#extra_order_cart').length) {
                calcExtraOrder();
            }
        });

        $('input[name="order[preorder]"]').trigger('change'); // скрываем/отображаем блок с датой доставки

        $('.date').datepicker({dateFormat: 'dd.mm.yy', dayNamesMin: ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"], firstDay: 1, monthNames: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"], minDate: 0});

        $('#content').on('change', 'input[name="order[preorder]"]:checked', function () {
            if ($(this).val() == 1) {
                $('#preorder_date').css('display', 'block');
            } else {
                $('#preorder_date').css('display', 'none');
            }
        });

        calcExtraOrder();

    });

    $('#preorder_date input[name="order[delivery_date]"]').change(function () {
        var delivery_date = $('#preorder_date input[name="order[delivery_date]"]').val();

        if (!isValidDate(delivery_date)) {
            alert('Укажите дату в формате ДД.ММ.ГГГГ');
            return;
        }

        $.ajax({
            url: 'index.php?route=extra/helper/getDisabledDeliveryTime&token=<?php echo $token; ?>',
            type: 'POST',
            data: 'delivery_date=' + delivery_date<?php
if (isset($this->request->get['order_id'])) {
    echo " + '&order_id=" . $this->request->get['order_id'] . "'";
}
?>,
            dataType: 'json',
            success: function (json) {
                var selected_time = $('#preorder_date select[name="order[delivery_time]"]').val();

                $('#preorder_date select[name="order[delivery_time]"] option').removeAttr('disabled');

                if (json['disabled']) {
                    $.each(json['disabled'], function (key, value) {
                        $('#preorder_date select[name="order[delivery_time]"] option[value="' + value + '"]').attr('disabled', true);
                    });
                }

                if ($('#preorder_date select[name="order[delivery_time]"] option[value="' + selected_time + '"]').is(':disabled')) {
                    $('#preorder_date select[name="order[delivery_time]"]').val(0);
                }
            }
        });
    });

    function saveOrder() {

        $.ajax({
            url: 'index.php?route=extra/order/jxSaveOrder&token=<?php echo $token; ?>',
            type: 'POST',
            data: $('#extra_order_form').serialize(),
            dataType: 'json',
            error: function (XHR) {
                //console.log(XHR.responseText);
            },
            success: function (json) {

                $('.warning').remove();

                if (json['redirect']) {
                    window.location = json['redirect'];
                }

                if (json['errors']) {
                    err_html = '';

                    $.each(json['errors'], function (key, value) {
                        err_html += value + '<br>';
                    });

                    $('#order_buttons').before('<div class="warning">' + err_html + '</div>');
                }
            }
        });
    }

    function cancelOrder(order_id) {

        if (confirm("Точно отменяем?")) {
            $.ajax({
                url: 'index.php?route=extra/helper/cancel&order_id=' + order_id + '&token=<?php echo $token; ?>',
                type: 'GET',
                dataType: 'json',
                data: 'order_id=' + order_id,
                
                error: function (XHR) {
                    //console.log(XHR.responseText);
                    location.href = location.href
                },
                success: function (resp) {
                    //console.log(resp);
                    location.href = location.href
                }
            });
        }
    }

    $('#button_save_order').click(function () {
        saveOrder();
    });

    $('#button_confirm_order').click(function () {

        var change_status_confirm = true;

        var preorder = parseInt($('#extra_order_info input[name="order[preorder]"]:checked').val());

        if (preorder) {
            var preorder_date = $('.date').datepicker('getDate');
            var preorder_time = $('#preorder_date select[name="order[delivery_time]"]').val().split(':');

            if (preorder_time.length <= 1) {
                alert('Укажите время предзаказа');
                return;
            }

            preorder_date.setHours(parseInt(preorder_time[0]));
            preorder_date.setMinutes(parseInt(preorder_time[1]));

            if (Math.round(new Date().getTime() / 1000) + <?php echo PREORDER_COFIRM_TIME; ?> < Math.round(preorder_date.getTime() / 1000)) {
                change_status_confirm = false;
            }
        }

        if (change_status_confirm) {
            $('#extra_order_info input[name="order[status_id]"]').val(<?php echo CONFIRM_ORDER_STATUS_ID; ?>);
            $('#extra_order_info input[name="order[date_confirm]"]').val(getDateTime(5));
        }

        saveOrder();
    });

    $('#button_get_distance').click(function () {
        getDistance();
    });

    $('input[name="customer[street]"], input[name="customer[house]"]').change(function () {
        getDistance();
    });

    $('input[name="bonusdata[withdraw]"]').change(function () {
        calcExtraOrder();
    });


    function getDistance() {
        $('.warning').remove();

        var cont = $('#clientcard');

        var city = cont.find('input[name="customer[city]"]').val();
        var street = cont.find('input[name="customer[street]"]').val();
        var house = cont.find('input[name="customer[house]"]').val();
        var flat = cont.find('input[name="customer[flat]"]').val();

        if (city.length > 0 && street.length > 0 && house.length > 0) {
            data = 'city=' + city + '&street=' + street + '&house=' + house;
            if (flat.length > 0) {
                data += '&flat=' + flat;
            }

            $('#delivery_info').addClass('loading');

            $.ajax({
                url: 'index.php?route=extra/helper/getDistance&token=<?php echo $token; ?>',
                type: 'POST',
                data: data,
                dataType: 'json',
                success: function (json) {
                    $('#delivery_info').removeClass('loading');

                    if (json['distance']) {
                        // $('#distance').html(json['distance']['text']);
                        $('#customer_distance').val(json['distance']['text']); //@<<<<<<<<<<<<<<<
                        $('#clientcard input[name="customer[distance]"]').val(json['distance']['value']);

                        d_price = getDeliveryPrice();

                        $('#delivery_price').html(d_price + 'р.');
                        $('#delivery_price').val(d_price + 'р.'); //@<<<<<<<<<<<<<<<

                        calcExtraOrder();
                    }

                    if (json['error']) {
                        $('#order_buttons').before('<div class="warning">' + json['error'] + '</div>');
                    }
                }
            });
        }
    }

    $(document).ready(function () {
        $('#preorder_input input').trigger('change');
        $('#preorder_date input[name="order[delivery_date]"]').trigger('change');

        getDistance();

        $('#extra_order_info input[name="order[biglion]"]').change(function () {
            if ($(this).is(':checked')) {
                $('#preorder_block input[name="order[preorder]"]').trigger('click');
                $('#preorder_date').css('display', 'block');
            }
        });
    });
</script>
<?php echo $footer; ?>