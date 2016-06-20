<h3>Корзина</h3>
<table id="extra_order_cart" class="list">
    <thead>
        <tr>
            <td>#</td>
            <td>Наименование</td>
            <td>Кол-во</td>
            <td>Цена</td>
            <td>Скидка
                <select name="customer[total_special]">
                    <?php foreach ($specials as $special) { ?>
                        <?php if ($special == $customer['total_special']) { ?>
                            <option value="<?php echo $special; ?>" selected="selected"><?php echo $special; ?>%</option>
                        <?php } else { ?>
                            <option value="<?php echo $special; ?>"><?php echo $special; ?>%</option>
                        <?php } ?>
                    <?php } ?>
                </select>
            </td>
            <td>Начислено бонусов</td>
            <td>Цена со скидкой</td>
            <td>Сумма</td>
            <td></td>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($products as $i => $product) { ?>
            <tr id="eo-row-<?php echo $product['product_id']; ?>">
                <td><?php echo ($i + 1); ?>
                    <div class="hidden-inputs" style="display: none">
                        <input class="eo-input-product-product_id"      type="hidden" name="products[<?php echo $product['product_id']; ?>][product_id]"      value="<?php echo $product['product_id']; ?>">
                        <input class="eo-input-product-price"           type="hidden" name="products[<?php echo $product['product_id']; ?>][price]"           value="<?php echo $product['price']; ?>">
                        <input class="eo-input-product-special"         type="hidden" name="products[<?php echo $product['product_id']; ?>][special]"         value="<?php echo $product['special']; ?>">
                        <input class="eo-input-product-total"           type="hidden" name="products[<?php echo $product['product_id']; ?>][total]"           value="<?php echo $product['total']; ?>">

                    </div>
                </td>
                <td class="eo-product-name"><?php echo $product['name']; ?></td>
                <td class="eo-product-quantity">
                    <div class="quantity">
                        <span class="button-qty-minus">-</span>
                        <input size="2" type="text" name="products[<?php echo $product['product_id']; ?>][quantity]" value="<?php echo $product['quantity']; ?>">
                        <span class="button-qty-plus">+</span>
                    </div>
                </td>
                <td class="eo-product-price"><?php echo $product['price']; ?></td>
                <td class="eo-product-special_percent">
                    <select name="products[<?php echo $product['product_id']; ?>][special_percent]">
                        <?php foreach ($specials as $special) { ?>
                            <?php if ($special == $product['special_percent']) { ?>
                                <option value="<?php echo $special; ?>" selected="selected"><?php echo $special; ?>%</option>
                            <?php } else { ?>
                                <option value="<?php echo $special; ?>"><?php echo $special; ?>%</option>
                            <?php } ?>
                        <?php } ?>
                    </select>
                </td>
                <td></td>
                <td class="eo-product-special"><?php echo $product['special']; ?></td>
                <td class="eo-product-total"><?php echo $product['total']; ?></td>
                <td><a onClick="removeFromCart(<?php echo $product['product_id']; ?>)">x</a></td>
            </tr>
        <?php } ?>
    </tbody>
</table>
<h3>Информация о заказе</h3>
<div id="extra_order_info">
    <div class="column-left">
        <div class="row">
            <label>По купону</label>
            <input type="hidden" name="order[biglion]" value="0">
            <?php if ($order['biglion']) { ?>
                <input type="checkbox" name="order[biglion]" value="1" checked="checked">
            <?php } else { ?>
                <input type="checkbox" name="order[biglion]" value="1">
            <?php } ?>
        </div>
        <div class="row">
            <label>Скидка на все</label>
            <select name="customer[total_special]">
                <?php foreach ($specials as $special) { ?>
                    <?php if ($special == $customer['total_special']) { ?>
                        <option value="<?php echo $special; ?>" selected="selected"><?php echo $special; ?>%</option>
                    <?php } else { ?>
                        <option value="<?php echo $special; ?>"><?php echo $special; ?>%</option>
                    <?php } ?>
                <?php } ?>
            </select>
        </div>
        <div class="row">
            <label>Кол-во персон</label>
            <input type="text" name="order[persons]" value="<?php echo $order['persons']; ?>">
        </div><br/>
        <div class="row bordered">
            <span class="heading-title">На какое время желаете заказать?</span>
            <div class="radio-block">
                <input type="radio" name="order[preorder]" value="0" <?php if ($order['preorder'] == 0) { ?>checked="checked"<?php } ?>>
                <label>На текущее время</label>
            </div>
            <div class="radio-block" id="preorder_block">
                <div id="preorder_input">
                    <span class="or">или</span>
                    <input type="radio" name="order[preorder]" value="1" <?php if ($order['preorder'] == 1) { ?>checked="checked"<?php } ?>>
                    <label>Предзаказ</label>
                </div>

                <div id="preorder_date">
                    <div>
                        <span class="note">Дата</span><br>
                        <input class="date" type="text" name="order[delivery_date]" value="<?php echo $order['delivery_date']; ?>">
                    </div>
                    <div>
                        <span class="note">Время</span><br>
                        <select name="order[delivery_time]">
                            <option value="0">----</option>
                            <?php foreach ($delivery_time as $delivery_time) { ?>
                                <?php if ($order['delivery_time'] == $delivery_time . ':00') { ?>
                                    <option value="<?php echo $delivery_time; ?>:00" selected="selected"><?php echo $delivery_time; ?></option>
                                <?php } else { ?>
                                    <option value="<?php echo $delivery_time; ?>:00"><?php echo $delivery_time; ?></option>
                                <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                </div>
            </div>
        </div>   
        <div class="row bordered">
            <?php foreach ($delivery_methods as $delivery_method_id => $delivery_method) { ?>
                <div class="radio-block">
                    <?php if ($delivery_method_id != 2) { ?>
                        <span class="or">или</span>
                    <?php } ?>
                    <?php if ($delivery_method_id == $order['delivery_id']) { ?>
                        <input type="radio" name="order[delivery_id]" value="<?php echo $delivery_method_id; ?>" checked="checked">
                    <?php } else { ?>
                        <input type="radio" name="order[delivery_id]" value="<?php echo $delivery_method_id; ?>">
                    <?php } ?>
                    <label>
                        <?php if ($delivery_method_id == 1) { ?>
                            Заберете сами?
                        <?php } else { ?>
                            <?php echo $delivery_method; ?>
                        <?php } ?>
                    </label>
                </div>
            <?php } ?>
        </div>   

        <div class="row bordered">
            <span class="heading-title">Способ оплаты?</span>
            <?php foreach ($payment_methods as $payment_method_id => $payment_method) { ?>
                <div class="radio-block">
                    <?php if ($payment_method_id != 1) { ?>
                        <span class="or">или</span>
                    <?php } ?>
                    <?php if ($payment_method_id == $order['payment_id']) { ?>
                        <input type="radio" name="order[payment_id]" value="<?php echo $payment_method_id; ?>" checked="checked">
                    <?php } else { ?>
                        <input type="radio" name="order[payment_id]" value="<?php echo $payment_method_id; ?>">
                    <?php } ?>
                    <label><?php echo $payment_method; ?></label>
                </div>
            <?php } ?>
        </div>

        <div class="row bordered">
            <? /* ?><label>Сдача с</label>
              <input type="text" name="" value=""><? /* */ ?>
            <? /* ?><input type="text" name="order[cashback]" value="<?php echo $order['cashback']; ?>"><? /* */ ?>
        </div>

        <div class="row bordered" id="order_comment"><br/>
            <label>Примечание</label>
            <textarea name="order[comment]"><?php echo $order['comment']; ?></textarea>
        </div>
    </div>
    <div id="extra_total_info" class="column-right">
        <div class="hidden-inputs">
            <input type="hidden" name="order[status_id]" value="<?php echo $order['status_id']; ?>">
            <input type="hidden" name="order[date_confirm]" value="<?php echo $order['date_confirm']; ?>">
            <?php if (isset($order['order_id'])) { // заказ с сайта ?>
                <input type="hidden" name="order[order_id]" value="<?php echo $order['order_id']; ?>">
            <?php } ?>
            <?php if (isset($customer['customer_id'])) { ?>
                <input type="hidden" name="customer[customer_id]" value="<?php echo $customer['customer_id']; ?>">
            <?php } ?>
            <?php if (isset($this->request->get['save'])) { // редактирует кассир ?>
                <input type="hidden" name="redirect_route" value="extra/order/all">
            <?php } ?>
        </div>
        <table>
            <tr>
                <td>Итого: </td>
                <td class="eo-order-total_price"></td>
            </tr>
            <tr>
                <td>Скидка: </td>
                <td class="eo-order-special_percent"></td>
            </tr>
            <tr>
                <td>Списано бонусов: </td>
                <td class="eo-order-withdraw"></td>
            </tr>
            <tr>
                <td>Итого <br/><span class="note">со скидкой: </span></td>
                <td class="eo-order-total_special"></td>
            </tr>
            <tr>
                <td>Доставка: </td>
                <td class="eo-order-delivery"></td>
            </tr>
            <tr>
                <td>Всего: </td>
                <td class="eo-order-total"></td>
            </tr>
        </table>
    </div>
    <? if ($_SERVER['REMOTE_ADDR'] != '695.28.91.138'): ?>
        <div class="column-right">
            <div style="margin-bottom: 5px;">
                <label for="codePhone">Номер телефона:</label>  <br> <input type="text" id="codePhone" name="phone" pattern="[0-9]{10}"
                                                                            placeholder="9001234567">
                <label for="codeCode">Промокод:</label> <input type="text" id="codeCode" name="code">
                <br><span id="answerRes"></span>
            </div>
            <div>
                <input type="button" id="getCode" value="Сгенерировать промокод">
                <input type="button" id="checkCode" value="Проверить промокод">
                <input type="button" id="disableCode" value="Деактивировать промокод">
            </div>
            <script type="text/javascript">
                $(document).ready(function () {
                    $('#getCode').click(function () {
                        $('#getCode').prop("disabled", true);
                        $.ajax({
                            data: {action: 'getCode', phone: $('#codePhone').val()},
                            type: 'POST',
                            url: 'crutch/',
                            dataType: 'json',
                            success: function (data) {
                                if (data.status == 'success') {
                                    $('#answerRes').html(data.message);
                                    $('#answerRes').css('color', 'green');
                                } else if (data.status == 'fail') {
                                    $('#answerRes').html(data.message);
                                    $('#answerRes').css('color', 'red');
                                }
                            }
                        });
                        return false;
                    });

                    $('#checkCode').click(function () {
                        $.ajax({
                            data: {action: 'checkCode', code: $('#codeCode').val()},
                            type: 'POST',
                            url: 'crutch/',
                            dataType: 'json',
                            success: function (data) {
                                if (data.status == 'fail') {
                                    $('#answerRes').html(data.message);
                                    $('#answerRes').css('color', 'red');
                                } else {
                                    $('#answerRes').html('');
                                    $('#answerRes').css('color', 'green');
                                    $.each(data, function (index, element) {
                                        $('#answerRes').append(element.phone + '--' + element.time + '<br>');
                                    });
                                }
                            }
                        });
                        return false;
                    });

                    $('#disableCode').click(function () {
                        $.ajax({
                            data: {action: 'disableCode', phone: $('#codePhone').val(), code: $('#codeCode').val()},
                            type: 'POST',
                            url: 'crutch/',
                            dataType: 'json',
                            success: function (data) {
                                if (data.status == 'success') {
                                    $('#answerRes').html(data.message);
                                    $('#answerRes').css('color', 'green');
                                    $('#disableCode').prop("disabled", true);
                                    //                                alert(data.message);
                                } else if (data.status == 'fail') {
                                    $('#answerRes').html(data.message);
                                    $('#answerRes').css('color', 'red');
                                }
                            }
                        });
                        return false;
                    });
                });
            </script>
        </div>
    <? endif; ?>
</div>
<? /* ?><pre><? print_r($order) ?></pre><? /* */ ?>
<!-- NEW CARD ============================================================== -->

<style type="text/css">
    .newcard{
        display: block;
        position: relative; 
        background: #dfdfdf;
        border-radius: 4px;
        padding: 8px;
    }
    .col{
        /*position: relative;
        width: 33%;
        display: inline-block;
        vertical-align: top; */
    }
    .col > label{
        display: block;
        margin: 4px;
        padding: 4px;
    }
    .plate{
        position: relative;
        margin: 4px 0;
        padding: 4px 0;
    }

    .plate label{
        display: inline-block;
        *width: 120px; 
        min-width: 120px; 
    }

    .btn{
        position: relative;
        display: inline-block;
        text-align: center;
        background: #0077aa;
        color: #fff;
        font-weight: bold;
        text-transform: uppercase;
        padding: 1em;
        border-radius: 8px;
        box-shadow: 3px 3px 10px rgba(0,0,0,0.5);
        text-decoration: none;
    }
    .btn:active{
        top: 1px;
        box-shadow: 1px 1px 10px rgba(0,0,0,0.5);
    }
    .submitters{
        margin: 1ex 0;
        border-top: 1px solid #0077aa;
        padding: 1ex;
        text-align: right;
    }
</style>


<div class="newcard" id="clientcard">
    <h2>Ноавя карта клиента (разработка) BETA</h2>
    <table class="tablepatch" width="100%" border="0" celpadding="5">
        <tr valign="top">
            <td>
                <div class="col">
                    <h4>Контакты</h4>
                    <div class="plate">
                        <label>Имя *:</label><input type="text" name="customer[name]" value="<?= $customer["name"] ?>">
                    </div>
                    <div class="plate">
                        <label>Телефон АОН *:</label><input type="text" name="customer[phone]" value="<?= $customer["phone"] ?>">
                    </div>
                    <div class="plate">
                        <label>Телефон 2:</label><input type="text" name="customer[phone2]" value="<?= $customer["phone2"] ?>">
                    </div>
                </div>
            </td>
            <td>
                <h4>Адрес</h4>
                <div class="plate">
                    <label>Город:</label>
                    <? /* ?><?
                    $city_selected = empty($customer["city"]) ? 0 : $customer["city"];
                    $cities = array(
                        "Калининград",
                        "Гурьевск",
                        "Храброво",
                        "Космодемьянск"
                    );
                    ?>
                    <select name="customer[city]">
                        <? foreach($cities as $city):
                            $sel = "";
                            if($city_selected == $city){
                                $sel = "selected=\"selected\"";
                            }
                            ?>
                        <option value="<?=$city?>" <?=$sel?>><?=$city?></option>
                        <? endforeach; ?>
                    </select><? /* */ ?>
                    <? /* */ ?><input type="text" name="customer[city]" value="<?= $customer["city"] ?>"><?/* */ ?>
                </div>
                <div class="plate">
                    <label>Улица:</label><input type="text" name="customer[street]" value="<?= $customer["street"] ?>">
                </div>
                <div class="plate">
                    <label>Дом:</label><input type="text" name="customer[house]" value="<?= $customer["house"] ?>">
                </div>
                <div class="plate">
                    <label>Квартира / Офис:</label><input name="customer[flat]" type="text" value="<?= $customer["flat"] ?>">
                </div>
                <div class="plate">
                    <label>Этаж:</label><input type="text" name="order[floor]" value="<?= $order["floor"] ?>">
                </div>
            </td>
            <td>
                <h4>Бонусы</h4>

                <div class="plate">    
                    <div class="plate">
                        <label>Телефон:</label><input type="text" name="bonus_phone" value="<?= ($order["bc_phone"] ? $order["bc_phone"] : $customer["phone"]) ?>">
                    </div>
                    <div class="plate">
                        <label>Номер карты:</label><input type="text" name="bonus_account" value="<?= $order["bc_account"] ?>" placeholder="не найден">
                    </div>
                    <div class="plate">
                        <label>Баланс:</label><input readonly="readonly" name='bonus_balance' type="text" value="0">
                    </div>
                    <div class="plate">
                        <label><button type="button" id="bonus_search">Поиск</button></label> <label id="serverStatus" style="color: #900; font-weight: bold">Сервер оффлайн</label>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="3"><br><br></td>
        </tr>
        <tr valign="top">
            <td>&nbsp;</td>
            <td>
                <h4>Доставка</h4>
                <div class="plate">
                    <?
                    $disance = empty($order['distance']) ? (empty($customer['distance']) ? "" : $customer['distance']) : $order['distance'];
                    ?>
                    <label>Расстояние:</label><input id="customer_distance" readonly="readonly" placeholder="не определено" type="text" value="">
                    <input name="customer[distance]" type="hidden" value="<?= $disance; ?>">
                </div>
                <div class="plate">
                    <label>Цена доставки:</label><input id="delivery_price" readonly="readonly" placeholder="не определена" type="text" value="">
                </div>
            </td>
            <td>
                <h4>Начисление / Списание</h4>

                <div class="plate">
                    <label>Списать:</label><input name="bonus_withdraw" type="text" value="<?= $order["bc_withdraw"] ?>">
                </div>
                <div class="plate">
                    <label>Начислить:</label><input readonly="readonly" name="bonus_fill" type="text" value="<?= $order["bc_fill"] ?>">
                </div>
                <input type="hidden" id="bonusDelta" val="0">
            </td>
        </tr>
        <tr valign="top">
            <td colspan="3" align="right">
                <div class="submitters">
                    <?php if (isset($this->request->get['save'])) { ?>
                        <a class="btn" id="button_save_order">Сохранить заказ</a>
                    <?php } ?>
                    <a class="btn" id="button_confirm_order">Подтвердить заказ</a>
                </div>
            </td>
        </tr>
    </table>
</div>


<? /*  ?>
  <div class="newcard" id="clientcard" style="display: <? if (filter_input(INPUT_GET, "autologin") === "callcenter" && $phone == "9118537958"): ?>block<? endif; ?>">
  <h2>Ноавя карта клиента (разработка) BETA</h2>
  <div class="row">
  <div class="col">
  <h4>Контакты</h4>
  <div class="plate">
  <label>Имя *:</label><input type="text" name="customer[name]" value="<?= $customer["name"] ?>">
  </div>
  <div class="plate">
  <label>Телефон АОН *:</label><input type="text" name="customer[phone]" value="<?= $customer["phone"] ?>">
  </div>
  <div class="plate">
  <label>Телефон 2:</label><input type="text" name="customer[phone2]" value="<?= $customer["phone2"] ?>">
  </div>
  </div>

  <div class="col">
  <h4>Адрес</h4>
  <div class="plate">
  <label>Город:</label><input type="text" name="customer[city]" value="<?= $customer["city"] ?>">
  </div>
  <div class="plate">
  <label>Улица:</label><input type="text" name="customer[street]" value="<?= $customer["street"] ?>">
  </div>
  <div class="plate">
  <label>Дом:</label><input type="text" name="customer[house]" value="<?= $customer["house"] ?>">
  </div>
  <div class="plate">
  <label>Квартира / Офис:</label><input name="customer[flat]" type="text" value="<?= $customer["flat"] ?>">
  </div>
  <div class="plate">
  <label>Этаж:</label><input type="text" name="order[floor]" value="<?= $order["floor"] ?>">
  </div>
  <div class="plate">
  <div class="plate">
  <h4>Доставка</h4>
  </div>
  <div class="plate">
  <?
  $disance = empty($order['distance']) ? (empty($customer['distance']) ? "" : $customer['distance']) : $order['distance'];
  ?>
  <label>Расстояние:</label><input id="customer_distance" readonly="readonly" placeholder="не определено" type="text" value="">
  <input name="customer[distance]" type="hidden" value="<?= $disance; ?>">
  </div>
  <div class="plate">
  <label>Цена доставки:</label><input id="delivery_price" readonly="readonly" placeholder="не определена" type="text" value="">
  </div>
  </div>
  </div>

  <div class="col">
  <h4>Бонусы</h4>

  <div class="plate">
  <div class="plate">
  <label>Телефон:</label><input type="text" name="bonus_phone" value="<?= ($order["bc_phone"] ? $order["bc_phone"] : $customer["phone"]) ?>">
  </div>
  <div class="plate">
  <label>Номер карты:</label><input type="text" name="bonus_account" value="<?=$order["bc_account"]?>" placeholder="не найден">
  </div>
  <div class="plate">
  <label>Баланс:</label><input readonly="readonly" name='bonus_balance' type="text" value="0">
  </div>
  <div class="plate">
  <label><button type="button" id="bonus_search">Поиск</button></label> <label id="serverStatus" style="color: #900; font-weight: bold">Сервер оффлайн</label>
  </div>
  </div>
  <div class="plate">
  <h4>Начисление / Списание</h4>

  <div class="plate">
  <label>Списать:</label><input name="bonus_withdraw" type="text" value="<?=$order["bc_withdraw"]?>">
  </div>
  <div class="plate">
  <label>Начислить:</label><input readonly="readonly" name="bonus_fill" type="text" value="<?=$order["bc_fill"]?>">
  </div>
  <input type="hidden" id="bonusDelta" val="0">
  </div>
  </div>
  </div>
  <div class="submitters">
  <?php if (isset($this->request->get['save'])) { ?>
  <a class="btn" id="button_save_order">Сохранить заказ</a>
  <?php } ?>
  <a class="btn" id="button_confirm_order">Подтвердить заказ</a>
  </div>
  </div>
  <? /* */ ?>

<!-- NEW CARD . END ======================================================== -->
