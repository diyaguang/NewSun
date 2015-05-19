; (function ($, window) {
    var win = $(window),
        doc = $(document),
        boy = $("body"),
        global = {
            setHead: {},
            setBody: {},
            AiBody: {},
            AiHead: {}
        }
   // DatagridTools.create({url:"url地址",element:"$('#xxx')"})   //调用方法说明
    window["DatagridTools"] = {
        create: function (arg) {
            var self = this;
            $.get(arg.url, function (da) {

                self.setDatagrid(da,arg);

            });
            self.Event_global();
        },
        setDatagrid: function (arg,json) {

            var arg = eval("(" + arg + ")"),
    head = arg[0] && arg[0]["head"],
    body = arg[0] && arg[0]["body"],
    first,
    setBody = "[{";
            global.setHead = head;
            global.setBody = body;
            global.AiBody = body;
            global.AiHead = head;

            for (var i = 0 ; i < head.length; i++) {

                $.extend(head[i], { "align": "center", "formatter": setDgFormat, "editor": { "type": "datebox" } });//填补

            }
            // console.log(JSON.stringify(head));
            for (var j = 0 ; j < body[0]["values"].length; j++) {
                for (var f = 0; f < body.length; f++) {
                    if (f == 0) {
                        setBody += "\"" + head[f]["field"] + "\"" + ":" + "\"" + (body[f]["values"][j] || "") + "\"" + ",";
                    }
                    else {
                        //  console.log(body)
                        var check = (body[f]["isEdit"][j] == "true") ? "" : "off";
                      
                            setBody += "\"" + head[f]["field"] + "\"" + ":" + "\"<input name='field_"+j+"_"+"_"+f+"' readonly='readonly'  name='id" + head[f]["field"] + "' class='fieldInput " + check + "' id='id" + head[f]["field"] + "' index=" + j + " guid='" + head[f]["field"] + "'  value='" + (body[f]["values"][j] || "") + "'" + " />\","
                       
                       
                    }

                    if (f == head.length - 1) {
                        setBody += "},{"
                    }
                }

            }
            setBody = setBody.replace(/\,\}/ig, "}").slice(0, -2) + "]";

            function setDgFormat(value, row) { //格式化
                // console.log(row);

                return value;

            }

           // console.log(JSON.stringify(eval(setBody)));
            //表$("#treeGread")
            $(json.element).datagrid({
                width: "auto",
                idField: 'ID',
                singleSelect: true,
                treeField: 'TemplateName',
                fitColumns: true,
                frozenColumns: [head.slice(0, 1)],
                columns: [head.slice(1)],
                data: eval("(" + setBody + ")"),
                onLoadSuccess: function () {
                    //setTimeout(function () {
                    //    console.log($(".fieldInput").width())
                    //    $(".fieldInput").datebox({});

                    //})
                }




            });
        },
        Event_Change: function (th) {
       
            if (th.hasClass("fieldInput")) {
                var value = th.val(),
                    ind = th.attr("index"),
                    id = th.attr("guid");
               
                for (var i = 0 ; i < global.setBody.length; i++) {
                    console.log(global.setBody[i]["id"]+"="+ id)
                    if (global.setBody[i]["id"] == id) {
                        global.AiBody[i]["values"][ind] = value;
                          //console.log(global.setBody[i]);
                        var getHead = JSON.stringify(global.AiHead),
                            getBody = JSON.stringify(global.AiBody);
                       
                        $("#greadData").val("[{ \"head\":" + getHead + ",\"body\":" + getBody + "}]");
                    }
                }

            }

        },
        Event_global: function () {
            var self = this,
                elements = "";
            doc.on("change", ".fieldInput", function () {
                var th = $(this);
                self.Event_Change(th);
            })
            doc.on("mouseup", function (ev) {
                var th = $(this),
                    id = th.attr("id"),
                    tar = $(ev.target);
                //console.log(tar.hasClass("off"));
                if (tar.hasClass("off")) { return };
                if (tar.hasClass("fieldInput")) {

                    $(".w_datebox").remove();
                    var top = tar.offset().top /*+ win.scrollTop()*/,
                        left = tar.offset().left /*+ win.scrollLeft()*/,
                        date = $("<div class='w_datebox'></div>"),
                    w_l = boy.width();
                    left = (left + 176 > w_l) ? left - (left + 185 - w_l) : left;
                    date.css({ "left": left + "px", "top": top + "px" });
                    // console.log(top)

                    boy.append(date);
                    var arr = tar.val().split("-");
                        
                    var currents = tar.val() ? (!-[1, ]) ? new Date(parseInt(arr[0]), parseInt(arr[1]) - 1, parseInt(arr[2])) : new Date(parseInt(arr[0]), parseInt(arr[1]) - 1, parseInt(arr[2])) : new Date();

                    date.calendar({
                        'year': currents.getFullYear(),
                        'month': currents.getMonth() + 1,
                        'onSelect': function (date) {

                            var y = date.getFullYear(), m = (date.getMonth() + 1), d = date.getDate()
                            tar.val(y + "-" + (m < 10 ? "0" + m : m) + "-" + (d < 10 ? "0" + d : d))
                            $(".w_datebox").remove();
                            self.Event_Change(tar);
                            elements = tar;
                        }
                    });
                       
                    $(".w_datebox").css({"height":"196px"}).append("<div class='footerBox'><a href='javascript:;' class='J_delete'>清除</a></div>")
                } else if (tar.closest(".w_datebox").length <= 0) {

                    $(".w_datebox").remove();
                }





            })
            doc.on("click", ".J_delete", function () {
                var th = $(this);
                $(elements).val("");
                $(".w_datebox").remove();
                
            })
        }
    }




})(jQuery, window)