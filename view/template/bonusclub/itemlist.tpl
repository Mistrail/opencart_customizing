<?=

$header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <div class="htabs">
        <a href="/admin/index.php?route=module/bonusclub&token=<?=$this->session->data["token"]?>">Настройки Bonusclub API</a>
        <a href="/admin/index.php?route=module/bonusclub/emulate&token=<?=$this->session->data["token"]?>">Эмуляция</a>
        <a ref="/admin/index.php?route=module/bonusclub/api&token=<?=$this->session->data["token"]?>">Методы API</a>
        <a class="selected" href="/admin/index.php?route=module/bonusclub/itemlist&token=<?=$this->session->data["token"]?>">Баллы для товаров</a>
        <a href="/admin/index.php?route=module/bonusclub/c_trigger&token=<?=$this->session->data["token"]?>">Триггеры баллов корзины</a>
        <a href="/admin/index.php?route=module/bonusclub/o_trigger&token=<?=$this->session->data["token"]?>">Триггеры баллов для заказа</a>
    </div>
    <div class="box">
        <div class="heading"><h1><img src="view/image/module.png" alt> <?=$this->document->getTitle()?></h1></div>
        <div class="content auto-height">

            <div class="leftcol">
                <ul>
            <? foreach($this->data["categories"] as $category):?>
                    <li><a href="?route=module/bonusclub/itemlist&category_id=<?=$category["category_id"]?>&token=<?=$this->session->data["token"]?>"><?=$category["name"] ?></a></li>
            <? endforeach;?>
                </ul>
            </div>
            <div class="rightcol">
                <form method="post">
                    <input type="hidden" name="action" value="batchUpdateBonuspoints">
                    <table class="list">
                        <thead>
                            <tr>
                                <td class="right">ID</td>
                                <td>Название</td>
                                <td class="right">Цена</td>
                                <td>Валюта</td>
                                <td class="right">Начислить баллов за покупку</td>
                            </tr>
                        </thead>
                        <tbody>
            <? foreach($this->data["products"] as $item):?>
                            <tr>
                                <td class="right"><?=$item["product_id"]?></td>
                                <td><?=$item["name"]?></td>
                                <td class="right"><?=$item["price"]?></td>
                                <td><?=$item["currency"]?></td>
                                <td class="right">
                                    <input type="number" min="0" name="bonus_points[<?=$item["product_id"]?>]" value="<?=$item["bonus_points"]?>">
                                </td>
                            </tr>
                <? endforeach;?>
                            <tr>
                                <td colspan="5">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="4">&nbsp;</td>
                                <td><input type="submit" value="Сохранить"></td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
            <div style="clear: both">&nbsp;</div>

        </div>
    </div>
</div>

<?= $footer?>