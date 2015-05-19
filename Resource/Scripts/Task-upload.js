
//上传exel回调
var self_Fun = {
    Event_inof: function () {
      //  console.log(iss._data);

    },
    Event_open: function (th) {

        var set = th.settings,
            _id = $("#" + set.queueID),
            pid = $("#" + set.id).parent();
        pid.css({ "position": "relative", "top": 0, "left": 0,"overflow":"hidden","zoom":"1" }).append("<p class='error_p' style='position:absolute;top:25px;right:10px;'><a href='javascript:;'  onclick='self_Fun.extend()'>全部显示</a><a href='javascript:;' style='margin-left:10px'  onclick='self_Fun.clear()'>清除</a>")
        _id.css({ "float": "left", "width": "200px" }).parent().css({ "overflow": "hidden" }).append("<div class='error-info' style='margin-left:210px; height:260px;border:#ccc solid 1px;overflow:hidden;overflow-y:auto;background:#fcfcfc'></div>")
        iss.data("$pid", pid);

    },
    extend: function () {
        iss.data("opens", null);
        var pid = iss.data("$pid"),
            art = iss.dialog.alert({
                "title": "详细信息", "url": "about:blank", "width": 1000, "height": 420, "okValue": "关闭", "go": function () {
                    iss.data("opens", this.iframe.contentWindow);
                    this.iframe.contentWindow.document.write(iss.data("tem_json") ? iss.data("tem_json") : "");
                    this.iframe.contentWindow.document.body.className = "error_iframe";
                    $('<link href="/Content/css/css.css" rel="stylesheet"/><link href="/Content/css/iss.css" rel="stylesheet"/>').appendTo(this.iframe.contentWindow.document.getElementsByTagName("head"));
                }
            });
        // arg = window.open("", "", "width=1000,height=460");
        // arg.document.body.innerHTML = iss.data("tem_json") ? iss.data("tem_json") : "处理信息。。。";
    },
    clear: function () {
        var pid = iss.data("$pid");
        pid.find(".error-info").html("");
        iss.data("tem_json", "");
    }

}


// 初始化
//$(function () {
//    $("#txtOverTime").datebox();
// });

///  解析时间
function GetTime(result) {
    if (!result) return null;
    result = new Date(parseInt(result.replace("/Date(", "").replace(")/", ""), 10));
    return result.Format("yyyy-MM-dd hh:mm:ss");
}




