<?php echo $header; ?>
<div id="content">
  <?
  /*
  TODO: здесь в циклах обнуляется стоимость доставки при самовывозе, но вообще надо пофиксить, чтобы оно изначально
  туда не считало в подобном случае
  */

  ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/category.png" alt="" />Заказы</h1>
      <div class="buttons" style="float: left; margin-left: 30px;">
        <form id="delivery_time_form" method="POST" action="">
          <span style="font-size: 90%">Время доставки: </span>
          <input class="success-box" type="text" name="delivery_time" value="<?php echo $delivery_time; ?>">
          <a id="button_delivery_time" class="dotted"><span>сохранить</span></a>
        </form>
      </div>
      <div class="buttons" style="float: left; margin-left: 30px;">
        <form id="extra_comment_form" method="POST" action="">
          <span style="font-size: 90%">Комментарий для оператора:</span>
          <input size="40" class="success-box" type="text" name="extra_comment" value="<?php echo $extra_comment; ?>">
          <a id="button_extra_comment" class="dotted"><span>сохранить</span></a>
        </form>
      </div>
      <div class="buttons">
        <a target="_blank" class="button" href="<?php echo $href_x_report; ?>">X-Отчет</a>
        <a target="_blank" class="button" href="<?php echo $href_z_report; ?>">Z-Отчет</a>
      </div>
    </div>
    <div class="content auto-height">
      <h2>Предзаказ</h2>
      <table class="list">
        <thead>
          <tr>
            <td class="left">№</td>
            <td class="left">Имя покупателя</td>
            <td class="left">Предзаказ</td>
            <td class="left">Время принятия</td>
            <td class="left">Время доставки</td>
            <td class="left">Сумма <span class="note">(всего/скидка/итого)</span></td>
            <td class="left">Контактная информация</td>
            <td class="left">Состав заказа</td>
            <td class="right">Действия</td>
          </tr>
        </thead>
        <tbody>
          <?php if (isset($orders[CONFIRM_ORDER_STATUS_ID]) && !empty($orders[CONFIRM_ORDER_STATUS_ID])) { ?>
            <?php foreach ($orders[CONFIRM_ORDER_STATUS_ID] as $order) { ?>
            <?php if (!$order['preorder']) continue; ?>
            <tr data-order-id="<?php echo $order['order_id']; ?>">
              <td class="left"><?php echo $order['number']; ?></td>
              <td class="left"><?php echo $order['customer_name']; ?></td>
              <td class="left">
                <?php if ($order['preorder']) { ?>
                V
                <?php } else { ?>
                X
                <?php }
                echo $order['payment_method']; ?>
              </td>
              <td class="left"><?php echo $order['confirm_time']; ?></td>
              <td class="left">
              <?php if ($order['delivery_date'] != date('d.m.Y')) { ?>
                <span class="note"><?php echo $order['delivery_date']; ?></span>
              <?php } ?>
              <?php echo $order['delivery_time']; ?>
              </td>
              <td class="left">
                <?php echo $order['total']; ?> / <?php echo $order['special_percent']; ?> / 
                <?php $sum = $order['total_special'] + $order['total_diff']; ?>
                <?php echo ($sum > FREE_DELIVERY_TOTAL) ? $sum : $sum + $order['delivery_price']; ?>
              </td>
              <td class="left">
                <?php echo $order['phone']; ?><br>
                <?php if ($order['phone2'] && $order['phone2'] != $order['phone']) { ?>
                  <?php echo $order['phone2']; ?><br>
                <?php } ?>
                <?php echo $order['address']; ?>
              </td>
              <td class="left">
                <?php foreach ($order['products'] as $product) { ?>
                  <?php echo $product['name']; ?> — <?php echo $product['quantity']; ?> шт.<br>
                <?php } ?>
                <i><?php echo $order['comment']; ?></i>
              </td>
              <td class="right">
                [<a onClick="changeOrderTotal(<?php echo $order['order_id']; ?>, <?php echo $order['total_special'] + $order['total_diff']; ?>, <?php echo $order['payment_id']; ?>)">Изменить сумму</a>]
                <!--[<a href="<?php echo $order['href_change_status']; ?>">Подтвердить</a>]-->
                [<a href="<?php echo $order['href_edit']; ?>">Редактировать</a>]
                [<a onClick="setOrderPrepare(<?php echo $order['order_id']; ?>)">В доставку</a>]
              </td>
            </tr>
            <?php } ?>
          <?php } else { ?>
          <tr><td colspan="9">Нет заказов</td></tr>
          <?php } ?>
        </tbody>
      </table>
      <h2>Обработанные</h2>
      <table class="list">
        <thead>
          <tr>
            <td class="left">№</td>
            <td class="left">Имя покупателя</td>
            <td class="left">Предзаказ</td>
            <td class="left">Время принятия</td>
            <td class="left">Время доставки</td>
            <td class="left">Сумма <span class="note">(всего/скидка/итого)</span></td>
            <td class="left">Контактная информация</td>
            <td class="left">Состав заказа</td>
            <td class="right">Действия</td>
          </tr>
        </thead>
        <tbody>
          <?php if (isset($orders[CONFIRM_ORDER_STATUS_ID]) && !empty($orders[CONFIRM_ORDER_STATUS_ID])) { ?>
            <?php foreach ($orders[CONFIRM_ORDER_STATUS_ID] as $order) { ?>
            <?php if ($order['preorder']) continue; ?>
            <tr data-order-id="<?php echo $order['order_id']; ?>">
              <td class="left"><?php echo $order['number']; ?></td>
              <td class="left"><?php echo $order['customer_name']; ?></td>
              <td class="left">
                <?php if ($order['preorder']) { ?>
                V
                <?php } else { ?>
                X
                <?php }
                echo $order['payment_method']; ?>
              </td>
              <td class="left"><?php echo $order['confirm_time']; ?></td>
              <td class="left">
              <?php if ($order['delivery_date'] != date('d.m.Y')) { ?>
                <span class="note"><?php echo $order['delivery_date']; ?></span>
              <?php } ?>
              <?php echo $order['delivery_time']; ?>
              </td>
              <td class="left">
                <?php echo $order['total']; ?> / <?php echo $order['special_percent']; ?> / 
                <?php $sum = $order['total_special'] + $order['total_diff']; ?>
                <?$order['delivery_price']=$order['delivery_method']=='Самовывоз'?0:$order['delivery_price'];?>
                <?php echo ($sum > FREE_DELIVERY_TOTAL) ? $sum : $sum + $order['delivery_price']; ?>
              </td>
              <td class="left">
                <?php echo $order['phone']; ?><br>
                <?php if ($order['phone2'] && $order['phone2'] != $order['phone']) { ?>
                  <?php echo $order['phone2']; ?><br>
                <?php } ?>
                <?php echo $order['address']; ?>
              </td>
              <td class="left">
                <?php foreach ($order['products'] as $product) { ?>
                  <?php echo $product['name']; ?> — <?php echo $product['quantity']; ?> шт.<br>
                <?php } ?>
                <i><?php echo $order['comment']; ?></i>
              </td>
              <td class="right">
                [<a onClick="changeOrderTotal(<?php echo $order['order_id']; ?>, <?php echo $order['total_special'] + $order['total_diff']; ?>, <?php echo $order['payment_id']; ?>)">Изменить сумму</a>]
                <!--[<a href="<?php echo $order['href_change_status']; ?>">Подтвердить</a>]-->
                [<a href="<?php echo $order['href_edit']; ?>">Редактировать</a>]
                [<a onClick="setOrderPrepare(<?php echo $order['order_id']; ?>)">В доставку</a>]
              </td>
            </tr>
            <?php } ?>
          <?php } else { ?>
          <tr><td colspan="9">Нет заказов</td></tr>
          <?php } ?>
        </tbody>
      </table>
      <h2>Приготовление и доставка</h2>
      <table class="list">
        <thead>
          <tr>
            <td class="left">№</td>
            <td class="left">Имя покупателя</td>
            <td class="left">Предзаказ</td>
            <td class="left">Время принятия</td>
            <td class="left">Время доставки</td>
            <td class="left">Сумма <span class="note">(всего/скидка/итого)</span></td>
            <td class="left">Контактная информация</td>
            <td class="left">Состав заказа</td>
            <td class="right">Действия</td>
          </tr>
        </thead>
        <tbody>
          <?php if (isset($orders[PREPARE_ORDER_STATUS_ID]) && !empty($orders[PREPARE_ORDER_STATUS_ID])) { ?>
            <?php foreach ($orders[PREPARE_ORDER_STATUS_ID] as $order) { ?>
            <tr data-order-id="<?php echo $order['order_id']; ?>">
              <td class="left"><?php echo $order['number']; ?></td>
              <td class="left"><?php echo $order['customer_name']; ?></td>
              <td class="left">
                <?php if ($order['preorder']) { ?>
                V
                <?php } else { ?>
                X
                <?php }
                echo $order['payment_method']; ?>
              </td>
              <td class="left"><?php echo $order['confirm_time']; ?></td>
              <td class="left">
              <?php if ($order['delivery_date'] != date('d.m.Y')) { ?>
                <span class="note"><?php echo $order['delivery_date']; ?></span>
              <?php } ?>
              <?php echo $order['delivery_time']; ?>
              </td>
              <td class="left">
                <?php echo $order['total']; ?> / <?php echo $order['special_percent']; ?> / 
                <?php $sum = $order['total_special'] + $order['total_diff']; ?>
                <?$order['delivery_price']=$order['delivery_method']=='Самовывоз'?0:$order['delivery_price'];?>
                <?php echo ($sum > FREE_DELIVERY_TOTAL) ? $sum : $sum + $order['delivery_price']; ?>
              </td>
              <td class="left">
                <?php echo $order['phone']; ?><br>
                <?php if ($order['phone2'] && $order['phone2'] != $order['phone']) { ?>
                  <?php echo $order['phone2']; ?><br>
                <?php } ?>
                <?php echo $order['address']; ?>
              </td>
              <td class="left">
                <?php foreach ($order['products'] as $product) { ?>
                  <?php echo $product['name']; ?> — <?php echo $product['quantity']; ?> шт.<br>
                <?php } ?>
                <i><?php echo $order['comment']; ?></i>
              </td>
              <td class="right">
                [<a onClick="printCheck(<?php echo $order['order_id']; ?>)">Печать чеков(<?php echo $order['order_id']; ?>)</a>]
                [<a target="blank" href="http://banzai-sushi.ru/pdf/order_<?php echo $order['order_id']; ?>_cashVoucher.pdf">Открыть чек</a>]
                [<a onClick="changeOrderTotal(<?php echo $order['order_id']; ?>, <?php echo $order['total_special'] + $order['total_diff']; ?>, <?php echo $order['payment_id']; ?>)">Изменить сумму</a>]
                [<a href="<?php echo $order['href_change_status']; ?>">Доставлено</a>]
              </td>
            </tr>
            <?php } ?>
          <?php } else { ?>
          <tr><td colspan="9">Нет заказов</td></tr>
          <?php } ?>
        </tbody>
      </table>
      <? 
      // echo '<pre>';
      // var_dump($orders);
       ?>
      <h2>Доставленные за смену</h2>

      <table class="list">
        <thead>
          <tr>
            <td class="left">№</td>
            <td class="left">Имя покупателя</td>
            <td class="left">Предзаказ</td>
            <td class="left">Время принятия</td>
            <td class="left">Время доставки</td>
            <td class="left">Сумма <span class="note">(всего/скидка/итого)</span></td>
            <td class="left">Контактная информация</td>
            <td class="left">Состав заказа</td>
            <td class="right">Действия</td>
          </tr>
        </thead>
        <tbody>
          <?php if (isset($orders[COMPLETE_ORDER_STATUS_ID]) && !empty($orders[COMPLETE_ORDER_STATUS_ID])) { ?>
            <?php foreach ($orders[COMPLETE_ORDER_STATUS_ID] as $order) { ?>
            <tr>
              <td class="left"><?php echo $order['number']; ?></td>
              <td class="left"><?php echo $order['customer_name']; ?></td>
              <td class="left">
                <?php  if ($order['preorder']) { ?>
                V
                <?php } else { ?>
                X
                <?php } 
                echo $order['payment_method'];?>
              </td>
              <td class="left"><?php echo $order['confirm_time']; ?></td>
              <td class="left">
              <?php if ($order['delivery_date'] != date('d.m.Y')) { ?>
                <span class="note"><?php echo $order['delivery_date']; ?></span>
              <?php } ?>
              <?php echo $order['delivery_time']; ?>
              </td>
              <td class="left">
                <?php echo $order['total']; ?> / <?php echo $order['special_percent']; ?> / 
                <?php $sum = $order['total_special'] + $order['total_diff']; ?>
                <?$order['delivery_price']=$order['delivery_method']=='Самовывоз'?0:$order['delivery_price'];?>
                <?php echo ($sum > FREE_DELIVERY_TOTAL) ? $sum : $sum + $order['delivery_price']; ?>
              </td>
              <td class="left">
                <?php echo $order['phone']; ?><br>
                <?php if ($order['phone2'] && $order['phone2'] != $order['phone']) { ?>
                  <?php echo $order['phone2']; ?><br>
                <?php } ?>
                <?php echo $order['address']; ?>
              </td>
              <td class="left">
                <?php foreach ($order['products'] as $product) { ?>
                  <?php echo $product['name']; ?> — <?php echo $product['quantity']; ?> шт.<br>
                <?php } ?>
                <i><?php echo $order['comment']; ?></i>
              </td>
              <td class="right">
                [<a onClick="changeOrderTotal(<?php echo $order['order_id']; ?>, <?php echo $order['total_special'] + $order['total_diff']; ?>, <?php echo $order['payment_id']; ?>)">Изменить сумму</a>]
                [<a href="<?php echo $order['href_change_status']; ?>">Скрыть из z-отчета</a>]
              </td>
            </tr>
            <?php } ?>
          <?php } else { ?>
          <tr><td colspan="9">Нет заказов</td></tr>
          <?php } ?>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="5"></td>
            <td colspan="4" style="padding: 5px;">
            Итого в кассе: <b><?php echo ($total_special + $total_diff + $total_delivery); ?></b> руб.
            </td>
          </tr>
        </tfoot>
      </table>

<h2>Доставленные за смену (скрытые из z-отчета)</h2>

      <table class="list">
        <thead>
          <tr>
            <td class="left">№</td>
            <td class="left">Имя покупателя</td>
            <td class="left">Предзаказ</td>
            <td class="left">Время принятия</td>
            <td class="left">Время доставки</td>
            <td class="left">Сумма <span class="note">(всего/скидка/итого)</span></td>
            <td class="left">Контактная информация</td>
            <td class="left">Состав заказа</td>
            <td class="right">Действия</td>
          </tr>
        </thead>
        <tbody>
          <?php if (isset($orders[Z_INVISIBLE_ORDER_STATUS_ID]) && !empty($orders[Z_INVISIBLE_ORDER_STATUS_ID])) { ?>
            <?php foreach ($orders[Z_INVISIBLE_ORDER_STATUS_ID] as $order) { ?>
            <tr>
              <td class="left"><?php echo $order['number']; ?></td>
              <td class="left"><?php echo $order['customer_name']; ?></td>
              <td class="left">
                <?php  if ($order['preorder']) { ?>
                V
                <?php } else { ?>
                X
                <?php } 
                echo $order['payment_method'];?>
              </td>
              <td class="left"><?php echo $order['confirm_time']; ?></td>
              <td class="left">
              <?php if ($order['delivery_date'] != date('d.m.Y')) { ?>
                <span class="note"><?php echo $order['delivery_date']; ?></span>
              <?php } ?>
              <?php echo $order['delivery_time']; ?>
              </td>
              <td class="left">
                <?php echo $order['total']; ?> / <?php echo $order['special_percent']; ?> / 
                <?php $sum = $order['total_special'] + $order['total_diff']; ?>
                <?$order['delivery_price']=$order['delivery_method']=='Самовывоз'?0:$order['delivery_price'];?>
                <?php echo ($sum > FREE_DELIVERY_TOTAL) ? $sum : $sum + $order['delivery_price']; ?>
              </td>
              <td class="left">
                <?php echo $order['phone']; ?><br>
                <?php if ($order['phone2'] && $order['phone2'] != $order['phone']) { ?>
                  <?php echo $order['phone2']; ?><br>
                <?php } ?>
                <?php echo $order['address']; ?>
              </td>
              <td class="left">
                <?php foreach ($order['products'] as $product) { ?>
                  <?php echo $product['name']; ?> — <?php echo $product['quantity']; ?> шт.<br>
                <?php } ?>
                <i><?php echo $order['comment']; ?></i>
              </td>
              <td class="right">
                [<a onClick="changeOrderTotal(<?php echo $order['order_id']; ?>, <?php echo $order['total_special'] + $order['total_diff']; ?>, <?php echo $order['payment_id']; ?>)">Изменить сумму</a>]
                [<a href="<?php echo $order['href_change_status']; ?>">Вернуть в z-отчет</a>]
              </td>
            </tr>
            <?php } ?>
          <?php } else { ?>
          <tr><td colspan="9">Нет заказов</td></tr>
          <?php } ?>
        </tbody>
<!--         <tfoot>
          <tr>
            <td colspan="5"></td>
            <td colspan="4" style="padding: 5px;">
            Итого в кассе: <b><?php// echo ($total_special + $total_diff + $total_delivery); ?></b> руб.
            </td>
          </tr>
        </tfoot> -->
      </table>

    </div>
  </div>
  <div id="print_wrapper" style="display: none"></div>
</div>
<div style="display: none">
  <div id="change_order_popup">
    <div id="step_1">
      <form method="POST" action="">
        <label>Введите пароль:</label></br>
        <input type="password" name="password" value="">
        <input type="button" name="submit_password" value="ОК">
      </form>
    </div>
    <div id="step_2">
      <form method="POST" action="">
        <label>Сумма со скидкой:</label><br>
        <input type="text" name="total_special" value="0">
        <div>
          <?php foreach ($payment_methods as $payment_method_id => $payment_method) { ?>
          <div class="radio-block">
            <input type="radio" name="payment_id" value="<?php echo $payment_method_id; ?>">
            <label><?php echo $payment_method; ?></label>
          </div>
          <?php } ?>
        </div>
        <div style="clear: both">
          <input type="button" name="submit_order" value="Сохранить">
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript">
$('#button_delivery_time').click(function() {
  var delivery_time = $('#delivery_time_form input[name="delivery_time"]').val();
  
  $.ajax({
		url: 'index.php?route=extra/helper/delivery_time&token=<?php echo $token; ?>',
		type: 'post',
		data: 'delivery_time=' + delivery_time,
		dataType: 'json',
		success: function(json) {
      $('#delivery_time_form input[name="delivery_time"]').addClass('success-box');
      
      setInterval(function() {
        $('#delivery_time_form input[name="delivery_time"]').removeClass('success-box');
      }, 1000);
    }
  });
});

$('#button_extra_comment').click(function() {
  var extra_comment = $('#extra_comment_form input[name="extra_comment"]').val();
  
  $.ajax({
		url: 'index.php?route=extra/helper/extraComment&token=<?php echo $token; ?>',
		type: 'post',
		data: 'extra_comment=' + extra_comment,
		dataType: 'json',
		success: function(json) {
      $('#extra_comment_form input[name="extra_comment"]').addClass('success-box');
      
      setInterval(function() {
        $('#extra_comment_form input[name="extra_comment"]').removeClass('success-box');
      }, 1000);
    }
  });
});

var current_orders = new Array(
  <?php foreach ($orders as $status_id => $orders_list) { ?>
    <?php if ($status_id == CONFIRM_ORDER_STATUS_ID || $status_id == PREPARE_ORDER_STATUS_ID) { ?>
      <?php foreach ($orders_list as $order) { ?>
        <?php echo $order['order_id']; ?>,
      <?php } ?>
    <?php } ?>
  <?php } ?>
  0
);

current_orders.pop();

$(document).ready(function() {
  setInterval(function() {
    post_data = 'orders[]=' + current_orders.join('&orders[]=');
    
    $.ajax({
      url: 'index.php?route=extra/helper/check&token=<?php echo $token; ?>',
      type: 'post',
      data: post_data,
      dataType: 'json',
      success: function(json) {
        if (json['new_orders']) {
          location.reload();
        }
        
        if (json['canceled_orders']) {
          $.each(json['canceled_orders'], function(key, value) {
            current_orders.remove(parseInt(value));
            
            $('#content table tr[data-order-id="' + value + '"]').addClass('canceled');
          });
        }
      }
    });
  }, 1000 * 60 * 0.5);
});

$('#change_order_popup input[name="password"]:active').keypress(function(e) {
    if(e.which == 13) {
        $('#change_order_popup input[name="submit_password"]').trigger('click');
    }
});

function changeOrderTotal(order_id, total_special, payment_id) {
  $('#change_order_popup input[name="password"]').removeClass('err');
  $('#change_order_popup #step_1').css('display', 'block');
  $('#change_order_popup #step_2').css('display', 'none');
  
  $('#change_order_popup input[name="total_special"]').val(total_special);
  $('#change_order_popup input[type="radio"]').prop('checked', false);
  $('#change_order_popup input[type="radio"][value="' + payment_id + '"]').prop('checked', true);
  
  var password = '';
  
  $.colorbox({
    inline:true, 
    href:'#change_order_popup',
    width: '250',
    height: '200'
  });
  
  
  $('#change_order_popup input[name="submit_password"]').click(function() {
    $('#change_order_popup input[name="password"]').removeClass('err');
    
    password = $('#change_order_popup input[name="password"]').val();
    
    if (password.length == 0) {
      return;
    }
    
    $.ajax({
      url: 'index.php?route=extra/helper/password&token=<?php echo $token; ?>',
      type: 'POST',
      data: 'password=' + password,
      success: function(result) {
        if (result == 1) {
          $('#change_order_popup #step_1').css('display', 'none');
          $('#change_order_popup #step_2').css('display', 'block');
        } else {
          $('#change_order_popup input[name="password"]').addClass('err');
        }
      }
    });
  });
  
  $('#change_order_popup input[name="submit_order"]').click(function() {
  
    $.ajax({
      url: 'index.php?route=extra/helper/changeOrder&token=<?php echo $token; ?>',
      type: 'POST',
      data: 'order_id=' + order_id + '&total_special=' + $('#change_order_popup input[name="total_special"]').val() + '&payment_id=' + $('#change_order_popup input[name="payment_id"]:checked').val() + '&password=' + password,
      dataType: 'json',
      success: function(json) {
        if (json['redirect']) {
          window.location = json['redirect'];
        }
      }
    });
  });
}

function setOrderPrepare(order_id) {
  window.location = '<?php echo HTTP_SERVER; ?>index.php?route=extra/helper/changeStatus&order_id=' + order_id + '&status_id=<?php echo PREPARE_ORDER_STATUS_ID; ?>&print_check=' + order_id + '&token=<?php echo $token; ?>';
}


function printCheck(order_id) {
  $('#content #print_wrapper').html('');
  
  // var cash_vaucher_url = 'index.php?route=extra/report/cashVoucher&order_id=' + order_id + '&token=<?php echo $token; ?>';
  // var buyer_check_url = 'index.php?route=extra/report/buyerCheck&order_id=' + order_id + '&token=<?php echo $token; ?>';
    
  var cash_vaucher_url = 'index.php?route=extra/report/print_check&check_type=cashVoucher&order_id=' + order_id + '&copies=2&token=<?php echo $token; ?>';
  var buyer_check_url = 'index.php?route=extra/report/print_check&check_type=buyerCheck&order_id=' + order_id + '&token=<?php echo $token; ?>';
  
  $('#content #print_wrapper').append('<iframe src="' + cash_vaucher_url + '"></iframe>');
  // $('#content #print_wrapper').append('<iframe src="' + buyer_check_url + '"></iframe>');
}

<?php 
/* бэкап функции выше, на то время пока не разберусь с хромом и пдф

function setOrderPrepare(order_id) {
  window.location = '<?php echo HTTP_SERVER; ?>index.php?route=extra/helper/changeStatus&order_id=' + order_id + '&status_id=<?php echo PREPARE_ORDER_STATUS_ID; ?>&print_check=' + order_id + '&token=<?php echo $token; ?>';
}


function printCheck(order_id) {
  $('#content #print_wrapper').html('');
  
  // var cash_vaucher_url = 'index.php?route=extra/report/cashVoucher&order_id=' + order_id + '&token=<?php echo $token; ?>';
  // var buyer_check_url = 'index.php?route=extra/report/buyerCheck&order_id=' + order_id + '&token=<?php echo $token; ?>';
    
  var cash_vaucher_url = 'index.php?route=extra/report/print_check&check_type=cashVoucher&order_id=' + order_id + '&copies=2&token=<?php echo $token; ?>';
  var buyer_check_url = 'index.php?route=extra/report/print_check&check_type=buyerCheck&order_id=' + order_id + '&token=<?php echo $token; ?>';
  
  $('#content #print_wrapper').append('<iframe src="' + cash_vaucher_url + '"></iframe>');
  // $('#content #print_wrapper').append('<iframe src="' + buyer_check_url + '"></iframe>');
}


*/


if ($print_check) { ?>
  $(document).ready(function() {
    printCheck(<?php echo $print_check; ?>);
  });
<?php } ?>
</script>

<?php echo $footer; ?>