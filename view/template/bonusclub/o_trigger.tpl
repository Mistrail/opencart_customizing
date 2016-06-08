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
        <a href="/admin/index.php?route=module/bonusclub/api&token=<?=$this->session->data["token"]?>">Методы API</a>
        <a href="/admin/index.php?route=module/bonusclub/itemlist&token=<?=$this->session->data["token"]?>">Баллы для товаров</a>
        <a href="/admin/index.php?route=module/bonusclub/c_trigger&token=<?=$this->session->data["token"]?>">Триггеры баллов корзины</a>
        <a class="selected" href="/admin/index.php?route=module/bonusclub/o_trigger&token=<?=$this->session->data["token"]?>">Триггеры баллов для заказа</a>
    </div>
    <div class="box">
        <div class="heading"><h1><img src="view/image/module.png" alt> <?=$this->document->getTitle()?></h1></div>
        <div class="content auto-height">
            CONTENT
        </div>
    </div>
</div>

<?= $footer?>