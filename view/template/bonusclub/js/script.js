
$(document).ready(function () {
    $("button#test").click(testConnection);
    $("form#testData").submit(emulate);
    $("button#test").click();
    $("form#cTrigger").triggers();
})

var triggersProto = {
    data: [
        {
            values: {
                field: "cartSumm",
                cond: "lt",
                value: 0,
                logic: "then"
            },
            condType: "math"
        }
    ],
    options: {
    },
    bonus: $("<input type=\"text\" name=\"bonus\">"),
    handler: $("<input type=\"submit\">"),
    _create: function () {
        this.render();
    },
    render: function () {
        var obj, field, cond, logic, value;
        this.element.empty();
        var self = this;
        for (var i in this.data) {
            var data = this.data[i];
            obj = $("<div class=\"case\">");
            field = this.getField(data.condType, data.values.field);
            cond = this.getCond(this.getCondType(field.val()), data.values.cond);
            logic = this.getLogic(data.values.logic);
            value = this.getValue(cond.data().value, data.values.value);

            obj.append(field, cond, value, logic);
            this.element.append(obj);


        }

        var handlers = this.element.find("select");

        handlers.on("change", function () {
            var item = $(this);
            var index = item.parent().index();
            var value = item.val();


            if (item.attr("name") == "logic") {             
                if (item.val() == "then") { 
                    if (item.parent().next(".case").length) {
                        self.data.splice(index + 1);
                    }
                } else {                   
                    if (!item.parent().next(".case").length) {
                        self.data.push(self.getNewData());
                    }
                }
            }
            self.data[index].values[item.attr("name")] = value;
            self.render();
        });
        
        this.element.append(this.bonus, this.handler);
        
        this.handler.click(function(){
            self.save();
            return false;
        })
    },
    
    save: function () {
        var toSend = {
            conditions: [],
            action: "",
            bouns: this.element.find("[name=bonus]").val()
        };
        for(var i in this.data){
            toSend.conditions.push(this.data[i].values);
        }        
        
        console.log(toSend);
    },
    
    getNewData: function () {
        var item = {
            values: {
                field: "cartSumm",
                cond: "lt",
                value: 0,
                logic: "then"
            },
            condType: "math"
        }
        return item;
    },
    getCondType: function (val) {
        var options = {
            cartBonus: "math",
            cartSumm: "math",
            itemInCart: "items",
        }

        return options[val];
    },
    getValue: function (type, val) {
        var item;

        var valueList = {
            math: {
                type: "input",
                tag: $("<input name=\"value\">"),
                value: "0"
            },
            items: {
                type: "select",
                tag: $("<select name=\"value\">"),
                options: {
                    235: "Some option"
                }
            }
        }

        var obj = valueList[type];
        var item = obj.tag;

        if (obj.type === "select") {
            var option;
            for (var i in obj.options) {
                option = $("<option name=\"" + i + "\">").text(obj.options[i]);
                item.append(option);
            }
        }
        item.val(val);
        return item;
    },
    getCond: function (type, val) {
        var item = $("<select name=\"cond\">");
        var optionsList = {
            math: {
                lt: "LT",
                gt: "GT"
            },
            items: {
                hasBonus: "has Item",
                hasntBonus: "has`nt Item",
            }
        }

        var options = optionsList[type];
        item.data({value: type});

        var option;


        for (var i in options) {
            option = $("<option value=\"" + i + "\">").text(options[i]);
            item.append(option);
        }/* */

        item.val(val);
        return item;
    },
    getLogic: function (val) {
        var item = $("<select name=\"logic\">");

        var options = {
            then: "THEN",
            and: "AND",
            or: "OR",
            andNot: "AND NOT",
            orNot: "OR NOT"

        };
        var option;

        for (var i in options) {
            option = $("<option value=\"" + i + "\">").text(options[i]);
            item.append(option);
        }
        item.val(val);
        return item;
    },
    getField: function (cond, val) {
        var item = $("<select name=\"field\">");
        item.data({cond: cond});
        var options = {
            cartSumm: "CAtr SuMm",
            cartBonus: "CAtr Bonusse",
            itemInCart: "In caTrat",
        };
        var option;

        for (var i in options) {
            option = $("<option value=\"" + i + "\">").text(options[i]);
            item.append(option);
        }
        item.val(val);

        return item;
    }

};

$.widget("frost.triggers", triggersProto);

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
            console.log(resp);
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