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
        <a class="selected" href="/admin/index.php?route=module/bonusclub/api&token=<?=$this->session->data["token"]?>">Методы API</a>
    </div>
    <div class="box">
        <div class="heading"><h1><img src="view/image/module.png" alt> <?=$this->document->getTitle()?></h1></div>
        <div class="content auto-height">
            <table class="list">
                <thead>
                    <tr>
                        <td class="center">Название метода</td>
                        <td class="center">Параметры</td>
                        <td class="center">Описание</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="left">ControllerBonusclubApi::check</td>
                        <td class="left">нет</td>
                        <td class="left">Проверяет соединение с сервером транзакций.<br />
                            Возвращает <code>bool true|false</code></td>
                    </tr>
                    <tr>
                        <td class="left">ControllerBonusclubApi::gettoken</td>
                        <td class="left">нет</td>
                        <td class="left">Получает токен для текущей сессии обмена данными с сервером транзакций.<br />
                            Возвращает <code>string (32) | bool false</code></td>
                        </td>
                    </tr>
                    <tr>
                        <td class="left">ControllerBonusclubApi::getaccount</td>
                        <td class="left"><code>array("field" => "value" [, ...])</code></td></td>
                        <td class="left">Получает данные аккаунта клиента при наличии доступа к нему по заданному фильтру.<br />
                            Возвращает <code>array | bool false</code></td>
                    </tr>
                    <tr>
                        <td class="left">ControllerBonusclubApi::fill</td>
                        <td class="left"><code>int id_аккаунта, int сумма_начисляемых_баллов</code></td>
                        <td class="left">Получает данные аккаунта клиента при наличии доступа к нему по заданному фильтру.<br />
                            Возвращает <code>int [id транзакции] | bool false</code></td>
                    </tr>
                    <tr>
                        <td class="left">ControllerBonusclubApi::withdraw</td>
                        <td class="left"><code>int id_аккаунта, int сумма_списываемых_баллов</code></td>
                        <td class="left">Получает данные аккаунта клиента при наличии доступа к нему по заданному фильтру.<br />
                            Возвращает <code>int [id транзакции] | bool false</code></td>
                    </tr>
                    <tr>
                        <td class="left">ControllerBonusclubApi::history</td>
                        <td class="left"><code>int id_аккаунта, date(U) c | false, date(U) по | false</code></td>
                        <td class="left">Получает данные истории транзакций аккаунта клиента при наличии доступа к нему по заданному фильтру.<br />
                            Возвращает <code>array [список_транзакций] | bool false</code></td>
                    </tr>
                    <tr>
                        <td class="left">ControllerBonusclubApi::disconnect</a></td>
                        <td class="left">нет</td>
                        <td class="left">Отключается от сервера транзакций</td>
                    </tr>
                    <tr>
                        <td class="left">ControllerBonusclubApi::test</td>
                        <td class="left"><code>имя_дейстия, array(...)</code></td>
                        <td class="left">Возвращает отправленные данные в <code>JSON</code> из указанного обработчика на стороне сервера транзакции.<br />
                            Никакой записи/чтения пе производит. Функция сугубо для разработчиков.
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<?= $footer?>