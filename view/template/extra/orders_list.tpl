<?php echo $header; ?>
<div id="content">
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/category.png" alt="" /> Новые заказы</h1>
    </div>
    <div class="content">
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
            <?php if ($orders) { ?>
            <?php foreach ($orders as $order) { ?>
            <tr>
              <td class="left"><?php echo $order['customer_name']; ?></td>
              <td class="right"><?php echo $order['total']; ?></td>
              <td class="right"><?php echo $order['customer_phone']; ?>
                <!--<a onClick="copyToClipboard('<?php echo $order['customer_phone']; ?>')" class="dotted">[ <span>копировать </span>]</a>-->
              </td>
              <td class="right"><?php foreach ($order['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
    </div>
  </div>
</div>
<?php echo $footer; ?>