<?= $header; ?>
<style type="text/css">
    code{
        color: #06f;
        font-weight: bold;
    }
    .alert-warning{
        color: #fa0;
        font-weight: bold;
    }
    .alert-success{
        color: #090;
        font-weight: bold;
    }
    .alert-error{
        color: #a00;   
        font-weight: bold;
    }
    .checking{
        padding: 1em;
    }
    
    table.emulator{
        width: 90%
    }
    table.emulator td{
        vertical-align: bottom;
    }
    
    .testrequest{
        background: #ccc;
        padding: 1em;
    }
</style>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/module.png" alt> Настройки Bonusclub API</h1>
        </div>

        <form class="content form form-horizontal" method="post">
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
        <div>&nbsp;</div>
        <div class="heading"><h1><img src="view/image/module.png" alt>Эмуляция</h1></div>
        <div class="content">
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
                            <input type="submit" value="Проветить">
                        </form>
                    </td>
                    <td  width="50%" style="vertical-align: bottom">                        
                        <div class="testrequest"></div>
                        <a href="javascript:$('.testrequest').html('')">Очистить</a>
                    </td>
                </tr>
            </table>
        </div>

        <div>&nbsp;</div>
        <div class="heading"><h1><img src="view/image/module.png" alt> Методы API</h1></div>
        <div class="content">
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
                        <td class="left"><a href="#" class="checkMethod">ControllerBonusclubApi::check</a></td>
                        <td class="left">нет</td>
                        <td class="left">Проверяет соединение с сервером транзакций.<br />
                            Возвращает <code>bool true|false</code></td>
                    </tr>
                    <tr>
                        <td class="left"><a href="#" class="checkMethod">ControllerBonusclubApi::gettoken</a></td>
                        <td class="left">нет</td>
                        <td class="left">Получает токен для текущей сессии обмена данными с сервером транзакций.<br />
                            Возвращает <code>string (32) | bool false</code></td>
                        </td>
                    </tr>
                    <tr>
                        <td class="left"><a href="#" class="checkMethod">ControllerBonusclubApi::getaccount</a></td>
                        <td class="left"><code>array("field" => "value" [, ...])</code></td></td>
                        <td class="left">Получает данные аккаунта клиента при наличии доступа к нему по заданному фильтру.<br />
                            Возвращает <code>array | bool false</code></td>
                    </tr>
                    <tr>
                        <td class="left"><a href="#" class="checkMethod">ControllerBonusclubApi::fill</a></td>
                        <td class="left"><code>int id_аккаунта, int сумма_начисляемых_баллов</code></td>
                        <td class="left">Получает данные аккаунта клиента при наличии доступа к нему по заданному фильтру.<br />
                            Возвращает <code>int [id транзакции] | bool false</code></td>
                    </tr>
                    <tr>
                        <td class="left"><a href="#" class="checkMethod">ControllerBonusclubApi::withdraw</a></td>
                        <td class="left"><code>int id_аккаунта, int сумма_списываемых_баллов</code></td>
                        <td class="left">Получает данные аккаунта клиента при наличии доступа к нему по заданному фильтру.<br />
                            Возвращает <code>int [id транзакции] | bool false</code></td>
                    </tr>
                    <tr>
                        <td class="left"><a href="#" class="checkMethod">ControllerBonusclubApi::history</a></td>
                        <td class="left"><code>int id_аккаунта, date(U) c | false, date(U) по | false</code></td>
                        <td class="left">Получает данные истории транзакций аккаунта клиента при наличии доступа к нему по заданному фильтру.<br />
                            Возвращает <code>array [список_транзакций] | bool false</code></td>
                    </tr>
                    <tr>
                        <td class="left"><a href="#" class="checkMethod">ControllerBonusclubApi::disconnect</a></td>
                        <td class="left">нет</td>
                        <td class="left">Отключается от сервера транзакций</td>
                    </tr>
                    <tr>
                        <td class="left"><a href="#" class="checkMethod">ControllerBonusclubApi::test</a></td>
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
<script type="text/javascript">

    $(document).ready(function () {
        $("button#test").click();
        $("a.checkMethod").click();
    })

    $("form#testData").submit(function () {
        var form = $(this);
        var target = $("div.testrequest");
        var data = {};
        var params = form.find("input[name=field]");
        params.each(function () {
            var field = $(this).val();
            var value = $(this).next().val();
            data[field] = value
        })

        var send = {
            action: $("select[name=remote_action]").val(),
            data: data
        }
        var str = JSON.stringify(send);
        $.ajax({
            url: "index.php?route=bonusclub/api/test&token=<?= $this->session->data["token"] ?>",
            data: send,
            type: "post",
            beforeSend: function () {
                var out = target.html() + "<br />Отправляем <code>" + str + "</code>";
                target.html(out);
            },
            success: function (resp) {
                var out = target.html() + "<br />Получаем <code class=\"alert-success\">" + resp + "</code>";
                target.html(out);
            }
        })

        return false;
    })

    $("a.checkMethod").click(function () {
        var item = $(this);
        var target = $("div.checking");

        $.ajax({
            url: "index.php?route=bonusclub/api/checkmethod&token=<?= $this->session->data["token"] ?>",
            data: {
                method: item.html()
            },
            type: "post",
            async: true,
            success: function (resp) {
                if (resp == "1") {
                    target.html(target.html() + "<br />Метод <code>" + item.html() + "</code> <span  class=\"alert-success\">присутствует</span>");
                } else {
                    target.html(target.html() + "<br />Метод <code>" + item.html() + "</code> <span  class=\"alert-error\">отсутствует</span>");
                }
            }
        });
        return false;
    });
    $("button#test").click(function () {
        var target = $("div.checking");
        $.ajax({
            url: "index.php?route=bonusclub/api/check&token=<?= $this->session->data["token"] ?>",
            data: {
                public_key: $("input[name=public_key]").val()
            },
            type: "post",
            beforeSend: function () {
                target.html(target.html() + "<br /><span class=\"alert-warning\">Соединение с сервером...</span>");
            },
            success: function (resp) {
                if (resp == "ok") {
                    target.html(target.html() + "<br /><span class=\"alert-success\">Соеднение установлено</span>");
                } else {
                    target.html(target.html() + "<br /><span class=\"alert-error\">Соеднение не установлено</span>");
                }

            },
            error: function (XHR) {
                target.html(target.html() + "<br /><span class=\"alert-error\">Сбой проверки соединения!</span>");
            }
        })

        return false;
    })
</script>
<?=
$footer?>