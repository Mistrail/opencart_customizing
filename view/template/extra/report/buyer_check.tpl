<?php // echo $header; ?>
<?php $margin = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'; ?>
<!DOCTYPE html>
<head>
</head>
<body>
<div id="report" class="buyer-check">
  <div class="row" id="order_info">
    <div id="company_header" style="text-align: center;"><img style="height: 50px; width: auto;" src="<?php echo HTTP_IMAGE; ?>data/logo.png"></div>
    <div id="company_info" style="text-align: center;"><?php echo $company_info; ?>, <?php echo $company_address; ?></div>
    <table border="0" align="center">
      <tr>
        <td>Количество персон <b><?php echo $persons; ?></b></td>
        <td>Дата и время <b><?php echo date('d.m.Y H:i'); ?></b></td>
        <td>Доставить до <b><?php echo $delivery_time; ?></b></td>
      </tr>
    </table>
    <br/>
    <?php echo $margin; ?><table border="0" align="left">
      <tr>
      	<td>
        <b>Контактный телефон:</b><br/>
        &nbsp; 1) <?php echo $phone; ?>
        <?php if ($phone != $phone2) { ?><br/>
        &nbsp; 2) <?php echo $phone2; ?>
        <?php } ?>
        </td>
      	<td align="left">
        <b>Адрес доставки:</b><br/>
        &nbsp;&nbsp;<?php echo $address; ?><br/> Этаж: <?php echo $floor; ?>
        </td>
      </tr>
    </table>
    <?php if ($comment) { ?>
    <div><b>Примечание к заказу:</b> <?php echo $comment; ?></div>
    <?php } ?>
  </div>
  <div id="check_num" style="text-align: center;">
    <b>Товарный чек №<?php echo $order_num; ?></b>
  </div>
  <div class="row" id="products_info">
    <table border="1" id="products" cellpadding="2">
      <thead>
        <tr>
          <th>Наименование</th>
          <th>Количество</th>
          <th>Цена</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($products as $product) { ?>
        <tr>
          <td><?php echo $product['name']; ?></td>
          <td><?php echo $product['quantity']; ?></td>
          <td><?php echo $product['total']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <tfoot>
        <tr><td colspan="3">&nbsp;</td></tr>
        <tr>
          <td>Общая сумма</td>
          <td align="center" colspan="2"><?php echo $sum; ?></td>
        </tr>
        <?php if ($delivery_price) { ?>
        <tr>
          <td>Доставка</td>
          <td align="center" colspan="2"><?php echo $delivery_price; ?></td>
        </tr>
        <?php } ?>
        <tr>
          <td>Итого к оплате</td>
          <td align="center" colspan="2"><?php echo $total; ?></td>
        </tr>
        <tr><td colspan="3">&nbsp;</td></tr>
        <tr>
          <td>Кассир</td>
          <td align="center" colspan="2"></td>
        </tr>
      </tfoot>
    </table>
  </div>
  <br/>
  <br/>
  <br/>
  <br/>
  <br/>
  <br/>
  <br/>
  <br/>
  <div style="color: #FFFFFF;">.</div>
</div>
<?php // echo $footer; ?>
</body>