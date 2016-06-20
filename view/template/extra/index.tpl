<?php
echo $header;
?>

<div id="content">
<?php if ($success) { ?>
        <div class="success"><?php echo $success; ?></div>
    <?php } ?>
    <div class="box">
    <?php if ($extra_comment) { ?>
            <div class="extra-comment"><?php echo $extra_comment; ?></div>
        <?php } ?>
        <div class="heading">
            <h1><img src="view/image/category.png" alt="" /> Заказы с сайта</h1>
        </div>
        <div class="content auto-height">
            <table class="list">
                <thead>
                    <tr>
                        <td class="left">Имя покупателя</td>
                        <td class="right">Сумма заказа</td>
                        <td class="right">Дата поступления</td>
                        <td class="right">Телефон</td>
                        <td class="right">Действия</td>
                    </tr>
                </thead>
                <tbody>
<?php if (isset($orders[NEW_ORDER_STATUS_ID]) && !empty($orders[NEW_ORDER_STATUS_ID])) { ?>
                        <?php
                        foreach ($orders[NEW_ORDER_STATUS_ID] as $order) {
                            $tmp_date = $order["delivery_date"] . " " . $order["delivery_time"];
                            $pattern = "0000-00-00 00:00:00";
                            if ($tmp_date != $pattern) {
                                continue;
                            }
                            ?>
                            <tr>
                                <td class="left"><?php echo $order['customer_name']; ?>
        <?php if ($order['preorder']) { ?>
                                        <span class="note">предзаказ на 
                                        <?php if (date('d.m.Y') != date('d.m.Y', strtotime($order['delivery_date']))) { ?>
                                                <?php echo date('d.m.Y', strtotime($order['delivery_date'])) . ' - '; ?>
                                            <?php } ?>
                                            <?php echo date('H:i', strtotime($order['delivery_time'])); ?></span>
                                        <?php } ?>
                                </td>
                                <td class="right">
        <?php $sum = $order['total_special'] + $order['total_diff']; ?>
                                    <?php echo ($sum > FREE_DELIVERY_TOTAL) ? $sum : $sum + $order['delivery_price']; ?>
                                </td>
                                <td><?= date("d.m.Y H:i", strtotime($order["date_add"])); ?></td>
                                <td class="right"><?php echo $order['customer_phone']; ?>
                                  <!--<a onClick="copyToClipboard('<?php echo $order['customer_phone']; ?>')" class="dotted">[ <span>копировать </span>]</a>-->
                                </td>
                                <td class="right">
                                    <a href="<?php echo $order['href_edit']; ?>">Обработать</a>
                                </td>
                            </tr>
    <?php } ?>
                    <?php } else { ?>
                        <tr>
                            <td class="center" colspan="4">
                                Нет новых заказов
                            </td>
                        </tr>
<?php } ?>
                </tbody>
            </table>
        </div>

        <div class="heading">
            <h1><img src="view/image/category.png" alt="" /> Предзаказ</h1>
        </div>
        <div class="content auto-height">
            <table class="list">
                <thead>
                    <tr>
                        <td class="left">Имя покупателя</td>
                        <td class="right">Сумма заказа</td>
                        <td class="right">Телефон</td>
                        <td class="right">Действия</td>
                    </tr>
                </thead>
                <tbody>
<?php if (isset($orders[NEW_ORDER_STATUS_ID]) && !empty($orders[NEW_ORDER_STATUS_ID])) { ?>
                        <?php
                        foreach ($orders[NEW_ORDER_STATUS_ID] as $order) {
                            $tmp_date = $order["delivery_date"] . " " . $order["delivery_time"];
                            $pattern = "0000-00-00 00:00:00";
                            if ($tmp_date == $pattern) {
                                continue;
                            }
                            ?>
                            <tr>
                                <td class="left"><?php echo $order['customer_name']; ?>
        <?php if ($order['preorder']) { ?>
                                        <span class="note">предзаказ на 
                                        <?php if (date('d.m.Y') != date('d.m.Y', strtotime($order['delivery_date']))) { ?>
                                                <?php echo date('d.m.Y', strtotime($order['delivery_date'])) . ' - '; ?>
                                            <?php } ?>
                                            <?php echo date('H:i', strtotime($order['delivery_time'])); ?></span>
                                        <?php } ?>
                                </td>
                                <td class="right">
        <?php $sum = $order['total_special'] + $order['total_diff']; ?>
                                    <?php echo ($sum > FREE_DELIVERY_TOTAL) ? $sum : $sum + $order['delivery_price']; ?>
                                </td>
                                <td class="right"><?php echo $order['customer_phone']; ?>
                                  <!--<a onClick="copyToClipboard('<?php echo $order['customer_phone']; ?>')" class="dotted">[ <span>копировать </span>]</a>-->
                                </td>
                                <td class="right">
                                    <a href="<?php echo $order['href_edit']; ?>">Обработать</a>
                                </td>
                            </tr>
    <?php } ?>
                    <?php } else { ?>
                        <tr>
                            <td class="center" colspan="4">
                                Нет новых заказов
                            </td>
                        </tr>
<?php } ?>
                </tbody>
            </table>
        </div>


        <div class="heading" style="margin-top:20px">
            <h1><img src="view/image/category.png" alt="" /> Подтвержденные оператором</h1>
        </div>
        <div class="content auto-height">
            <table class="list">
                <thead>
                    <tr>
                        <td class="left">Имя покупателя</td>
                        <td class="right">Сумма заказа</td>
                        <td class="right">Телефон</td>
                        <td class="left">Адрес</td>
                        <td class="right">Дата подтверждения</td>
                        <td class="right">Действия</td>
                    </tr>
                </thead>
                <tbody>
<?php if (isset($orders[CONFIRM_ORDER_STATUS_ID]) && !empty($orders[CONFIRM_ORDER_STATUS_ID])) { ?>
                        <?php foreach ($orders[CONFIRM_ORDER_STATUS_ID] as $order) { ?>
                            <tr>
                                <td class="left"><?php echo $order['customer_name']; ?>
        <?php if ($order['preorder']) { ?>
                                        <span class="note">предзаказ</span>
                                    <?php } ?>
                                </td>
                                <td class="right">
        <?php $sum = $order['total_special'] + $order['total_diff']; ?>
                                    <?php echo ($sum > FREE_DELIVERY_TOTAL) ? $sum : $sum + $order['delivery_price']; ?>
                                </td>
                                <td class="right"><?php echo $order['customer_phone']; ?>
                                  <!--<a onClick="copyToClipboard('<?php echo $order['customer_phone']; ?>')" class="dotted">[ <span>копировать </span>]</a>-->
                                </td>
                                <td class="left"><?php echo $order["address"]; ?></td>
                                <td class="right">
                                    <span style="font-size: 85%"><?php echo $order['confirm_date']; ?></span> <?php echo $order['confirm_time']; ?>
                                </td>
                                <td class="right">
                                    <a href="<?php echo $order['href_edit']; ?>">Редактировать</a> | 
                                    <? /* ?><a class="dotted" onClick="cancelOrder(<?php echo $order['order_id']; ?>, this, true)"><span>Отменить</span></a><? /* */ ?>
                                </td>
                            </tr>
    <?php } ?>
                    <?php } else { ?>
                        <tr>
                            <td class="center" colspan="4">
                                Нет обработанных заказов
                            </td>
                        </tr>
<?php } ?>
                </tbody>
            </table>
        </div>
        <div class="heading" style="margin-top:20px">
            <h1><img src="view/image/category.png" alt="" /> Приготовление и доставка</h1>
        </div>
        <div class="content auto-height">
            <table class="list">
                <thead>
                    <tr>
                        <td class="left">Имя покупателя</td>
                        <td class="right">Сумма заказа</td>
                        <td class="right">Телефон</td>
                        <td class="right">Дата подтверждения</td>
                        <td class="right">Действия</td>
                    </tr>
                </thead>
                <tbody>
<?php if (isset($orders[PREPARE_ORDER_STATUS_ID]) && !empty($orders[PREPARE_ORDER_STATUS_ID])) { ?>
                        <?php foreach ($orders[PREPARE_ORDER_STATUS_ID] as $order) { ?>
                            <tr>
                                <td class="left"><?php echo $order['customer_name']; ?>
        <?php if ($order['preorder']) { ?>
                                        <span class="note">предзаказ</span>
                                    <?php } ?>
                                </td>
                                <td class="right">
        <?php $sum = $order['total_special'] + $order['total_diff']; ?>
                                    <?php echo ($sum > FREE_DELIVERY_TOTAL) ? $sum : $sum + $order['delivery_price']; ?>
                                </td>
                                <td class="right"><?php echo $order['customer_phone']; ?>
                                  <!--<a onClick="copyToClipboard('<?php echo $order['customer_phone']; ?>')" class="dotted">[ <span>копировать </span>]</a>-->
                                </td>
                                <td class="right">
                                    <span style="font-size: 85%"><?php echo $order['confirm_date']; ?></span> <?php echo $order['confirm_time']; ?>
                                </td>
                                <td class="right">
                                    <? /* ?><a class="dotted" onClick="cancelOrder(<?php echo $order['order_id']; ?>)"><span>Отменить</span></a><? /* */ ?>
                                </td>
                            </tr>
    <?php } ?>
                    <?php } else { ?>
                        <tr>
                            <td class="center" colspan="4">
                                Нет новых заказов
                            </td>
                        </tr>
<?php } ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
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
                    location.href = location.href
                }
            });
        }
    }
</script>
<?php echo $footer; ?>