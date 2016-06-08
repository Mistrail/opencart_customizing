
$(document).ready(function () {
    $("button#test").click(testConnection);    
    $("form#testData").submit(emulate);
    $("button#test").click();
})

function token() {
    var str = location.search;
    var exp = /token=([\w\d]{32})/gi;
    return exp.exec(str)[1];
}

function emulate() {
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
        url: "index.php?route=bonusclub/api/test&token=" + token(),
        data: send,
        type: "post",
        beforeSend: function () {
            var out = "<br />Отправляем <code>" + str + "</code>";
            target.html(out);
        },
        success: function (resp) {
            var out = target.html() + "<br />Получаем <code class=\"alert-success\">" + resp + "</code>";
            target.html(out);
        }
    })
    return false;
}

function testConnection() {
    var target = $("div.checking");
    $.ajax({
        url: "index.php?route=bonusclub/api/check&token=" + token(),
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
}