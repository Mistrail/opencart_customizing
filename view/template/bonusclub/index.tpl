<?= $header; ?>

<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <div class="htabs">
        <a class="selected" href="/admin/index.php?route=module/bonusclub&token=<?=$this->session->data["token"]?>">Настройки Bonusclub API</a>
        <a href="/admin/index.php?route=module/bonusclub/emulate&token=<?=$this->session->data["token"]?>">Эмуляция</a>
        <a href="/admin/index.php?route=module/bonusclub/api&token=<?=$this->session->data["token"]?>">Методы API</a>
        <a href="/admin/index.php?route=module/bonusclub/itemlist&token=<?=$this->session->data["token"]?>">Баллы для товаров</a>
        <a href="/admin/index.php?route=module/bonusclub/c_trigger&token=<?=$this->session->data["token"]?>">Триггеры баллов корзины</a>
        <a href="/admin/index.php?route=module/bonusclub/o_trigger&token=<?=$this->session->data["token"]?>">Триггеры баллов для заказа</a>
    </div>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/module.png" alt> <?=$this->document->getTitle()?></h1>
        </div>

        <form class="content auto-height form form-horizontal" method="post">
            <input type="hidden" name="action" value="saveConfig">
            <input type="hidden" name="token" value="<?= $this->session->data['token'] ?>">
            <div class="form-group">
                <label class="control-label col-lg-3">URL сервера</label>
                <div class="col-lg-9">
                    <input type="text" name="url" value="<?= $this->data['settings']["url"] ?>">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3">Публичный ключ</label>
                <div class="col-lg-9">
                    <textarea name="public_key" cols="128" rows="1"><?= $this->data['settings']["public_key"] ?></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3">Приватный ключ</label>
                <div class="col-lg-9">
                    <textarea name="private_key" cols="128" rows="6"><?= $this->data['settings']["private_key"] ?></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3"></label>
                <div class="col-lg-9">
                    <button class="btn btn-primary" type="submit">Сохранить</button>
                    <button class="btn btn-warning" id="test" type="button">Тестировать соединение</button>
                </div>
            </div>
            <div class="checking"></div>
        </form>
        
    </div>
</div>