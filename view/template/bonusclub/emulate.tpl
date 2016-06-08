<?= $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <div class="htabs">
        <a href="/admin/index.php?route=module/bonusclub&token=<?=$this->session->data["token"]?>">Настройки Bonusclub API</a>
        <a class="selected" href="/admin/index.php?route=module/bonusclub/emulate&token=<?=$this->session->data["token"]?>">Эмуляция</a>
        <a href="/admin/index.php?route=module/bonusclub/api&token=<?=$this->session->data["token"]?>">Методы API</a>
        <a href="/admin/index.php?route=module/bonusclub/itemlist&token=<?=$this->session->data["token"]?>">Баллы для товаров</a>
        <a href="/admin/index.php?route=module/bonusclub/c_trigger&token=<?=$this->session->data["token"]?>">Триггеры баллов корзины</a>
        <a href="/admin/index.php?route=module/bonusclub/o_trigger&token=<?=$this->session->data["token"]?>">Триггеры баллов для заказа</a>
    </div>
    <div class="box">
        <div class="heading"><h1><img src="view/image/module.png" alt> <?=$this->document->getTitle()?></h1></div>
        <div class="content auto-height">
            <table class="emulator">
                <tr>
                    <td width="50%" style="vertical-align: bottom">
                        <form method="post" id="testData">
                            <label>Действие: </label><select name="remote_action">
                                <option value="getToken">Получить токен</option>
                                <option value="getAccount">Получить данные аккаунта</option>
                                <option value="fill">начислить баллы</option>
                                <option value="withdraw">Списать баллы</option>
                                <option value="history">Получить историю</option>
                                <option value="disconnect">Отсоединиться</option>
                            </select><br />
                            <label>параметр 1: </label><input type="text" name="field"><input type="text" name="value"><br />
                            <label>параметр 2: </label><input type="text" name="field"><input type="text" name="value"><br />
                            <label>параметр 3: </label><input type="text" name="field"><input type="text" name="value"><br />
                            <label>параметр 4: </label><input type="text" name="field"><input type="text" name="value"><br />
                            <label>параметр 5: </label><input type="text" name="field"><input type="text" name="value"><br />
                            <input type="submit" value="Эмулировать выполнение">
                        </form>
                    </td>
                    <td  width="50%" style="vertical-align: bottom"><div class="testrequest"></div></td>
                </tr>
            </table>
        </div>
    </div>
</div>

<?= $footer?>