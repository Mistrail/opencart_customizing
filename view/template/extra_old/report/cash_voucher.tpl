<?php // echo $header; ?>
<!DOCTYPE html>
<html style="width: 80mm; max-height: 180mm;">
<head>
  <link rel="stylesheet" href="<?php echo HTTP_SERVER; ?>view/stylesheet/report.css"/>
</head>
<body>
<div id="report" class="cash-voucher">
  <div>
    <table id="top">
      <tr>
        <td align="left" style="font-size: 54px"><b><?php echo $persons; ?>X</b></td>
        <td align="center"><img style="height: 60px; width: auto;" src="<?php echo HTTP_IMAGE; ?>data/logo_image.png"></td>
        <td align="right" style="font-size: 54px"><b><?php echo $delivery_method; ?></b></td>
      </tr>
    </table>
    <div>
      <b>Доставить до <span style="font-size: 160%;"><?php echo $delivery_time; ?></span></b>
    </div>
    <div>
      <b>Адрес доставки: <span><?php echo $address; ?></span> <br/> Этаж: <?php echo $floor; ?></b>
    </div>
    <?php if ($phone) { ?>
    <div><b>Телефон:</b> <span><?php echo $phone; ?></span></div>
    <?php } ?>
    <div>
      <b>Способ оплаты:</b> <span><?php echo $payment_method; ?></span>
    </div>
    <?php if ($comment) { ?>
    <div>
      <b>Комментарий:</b> <span><?php echo $comment; ?></span>
    </div>
    <?php } ?>
    <div style="margin-top: 10px; text-align: center">
      Товарный чек №<?php echo $order_num; ?>
    </div>
    <div id="company_info" style="border: 1px dashed #000000">
      <?php echo $company_info; ?><br><?php echo $company_address; ?>
    </div>
    <div>
      Дата и время: <span style="font-size: 110%"><?php echo date('d.m.Y H:i'); ?></span>
    </div>
    <h3 style="text-align: center">Наименование:</h3>
    <div id="products_container" style="border: 1px solid #000000">
      <table>
      <?php foreach ($products as $product) { ?>
        <tr>
          <td colspan="4"><?php echo $product['name']; ?></td>
          <td><?php echo $product['quantity']; ?></td>
          <td><?php echo $product['total']; ?></td>
        </tr>
        <?php } ?>
      </table>
    </div>
    <div id="total">
      <table cellpadding="5">
        <tr>
          <td>Общая сумма (руб.):</td>
          <td><?php echo $sum; ?></td>
        </tr>
        <?php if ($delivery_price) { ?>
        <tr>
          <td>Доставка (руб.):</td>
          <td><?php echo $delivery_price; ?></td>
        </tr>
        <?php } ?>
        <tr>
          <td>Итого к оплате (руб.):</td>
          <td><?php echo $total; ?></td>
        </tr>
      </table>
    </div>
  </div>
</div>
<?php // echo $footer; ?>
</body>
</html>