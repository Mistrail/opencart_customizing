<?php echo $header; ?>
<div id="report" class="z-report">
  <div>
    <div style="text-align: center">
      <img src="<?php echo HTTP_IMAGE; ?>/data/logo_image.png">
    </div>
    <div style="margin-top: 10px; text-align: center">
      <b>Отчет закрытия смены<br>
      Z-Отчет № ___</b>
    </div>
    <div id="company_info">
      <?php echo $company_info; ?><br><?php echo $company_address; ?>
    </div>
    <div style="text-align: center;">
      Дата и время: <span style="font-size: 110%"><?php echo date('d.m.Y H:i'); ?></span>
    </div>
    <div id="products_container">
      <table>
        <thead>
          <tr>
            <th>Наименование</th>
            <th>Кол-во</th>
            <th>без скидки</th>
            <th>со скидкой</th>
            <th>себ-ть</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($products as $product) { ?>
          <tr>
            <td><?php echo $product['name']; ?></td>
            <td><?php echo $product['quantity']; ?></td>
            <td><?php echo $product['total']; ?></td>
            <td><?php echo $product['total_special']; ?></td>
            <td><?php echo round($product['upc']); ?></td>
          </tr>
          <?php } ?>
          <?php foreach ($delivery as $price => $count) { ?>
            <?php if ($price == 0) continue;  ?>
          <tr>
            <td>Доставка за <?php echo $price; ?></td>
            <td><?php echo $count; ?></td>
            <td><?php echo $price * $count; ?></td>
            <td><?php echo $price * $count; ?></td>
          </tr>
          <?php } ?>
          
        </tbody>
      </table>
    </div>
    <div id="total">
      <div style="overflow: hidden; margin: 10px 0;">Итого заказов за смену:<span style="float: right"><?php echo $orders_count; ?></span></div>
      <table class="total">
        <tr>
          <td>Продажа руб. без скидки:</td>
          <td align="right"><?php echo $total; ?></td>
        </tr>
        <tr>
          <td>Продажа руб. со скидкой:</td>
          <td align="right"><?php echo $total_special; ?></td>
        </tr>
        <tr>
          <td>Чистая прибыль:</td>
          <td align="right"><?php echo $total_special - $total_cost; ?></td>
        </tr>
          <!--<tr>
            <td>Гросс (тест):</td>
            <td align="right"><?php echo $gross; ?></td>
          </tr>-->
      </table>
      <div>В том числе:</div>
      <table class="total">
        <tr>
          <td>Наличные:</td>
          <td align="right"><?php echo $cash; ?></td>
        </tr>
        <tr>
          <td>Безналичный расчет:</td>
          <td align="right"><?php echo $cashless; ?></td>
        </tr>
      </table>
    </div>
  </div>
  <div id="bottom">
    <b>Ответственное лицо:</b>
    <table>
      <tr>
        <td>Должность:</td>
        <td class="field"></td>
      </tr>
      <tr>
        <td>Подпись:</td>
        <td class="field"></td>
      </tr>
    </table>
  </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
  window.print();
});
</script>
<?php echo $footer; ?>