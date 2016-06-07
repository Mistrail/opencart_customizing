<?php echo $header; ?>
<?php 
	/* $xxx_name = 'xxx_rep';
	while (file_exists($xxx_name . '.txt')){
		$xxx_name = $xxx_name . '1';
	}
*/
	//file_put_contents($xxx_name . '.txt', '|||cash='.$cash.'|||company_info='.$company_info.'|||total='.$total.'|||total_special='.$total_special.'|||cashless='.$cashless);
?>
<div id="report" class="x-report">
  <div>
    <h3 style="text-align: center; margin-top: 0;">X-Отчет</h3>
    <div id="company_info">
      <?php echo $company_info; ?>
    </div>
    <table class="total">
      <tr>
        <td>Продажа руб. без скидки:</td>
        <td><?php echo $total; ?></td>
      </tr>
      <tr>
        <td>Продажа руб. со скидкой:</td>
        <td><?php echo $total_special; ?></td>
      </tr>
    </table>
    <div>В том числе:</div>
    <table class="total">
      <tr>
        <td>Наличные:</td>
        <td><?php echo $cash; ?></td>
      </tr>
      <tr>
        <td>Безналичный расчет:</td>
        <td><?php echo $cashless; ?></td>
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