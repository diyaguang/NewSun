
$(function () {
    main_js.autowidth();//判断页面最大宽度
    //main_js.addMenu();//添加demo
    iss.tabs();
    $("html").css("background", "none");

});



var main_js = {
    autowidth: function () {
        var
            maxwin = parseInt(window.screen.availWidth) - 60;
        $(".content").css("width", maxwin + "px");
        $(".wap").css("min-width", maxwin + "px");
    },
    addMenu: function () {
        var
            mu = $(".J_nav"),
            html = $('<li><a href="javascript:void(0);">Demo</a><ul class="layer"><li><a href="../Demo/index">横向导航模板|前端控件说明</a></li><li><a href="../Demo/tabs">横向无导航模板|上传及搜索控件</a></li><li><a href="../Demo/table">两列模板</a></li></ul></li>');
        mu.append(html);
    },
    Ldownload: function (url, parm) {
        //main_js.Ldownload("xxx.aspx", {"orderName":"lvhuijie"})
        $("#iframe_download").remove();
        var iframe = $("<iframe id='iframe_download'  style='position:absolute;top:0;left:0;height:0;width:0;display:none' />").appendTo("body"),
            win = iframe[0].contentWindow,
            form = "<body><form action='" + url + "' method='post' > ";
        if (parm) {
            for (var i in parm) {
                form += "<input type='hidden' name='" + i + "' value='" + parm[i] + "' />";
            };
        }

        form += "</form></body>";
        win.document.write(form);
        win.document.getElementsByTagName("form").item(0).submit();
        // $(form).appendTo(win.document.body);//.submit();
        //$(form).submit();



    },
    tabScroll: function () {
        var box = $(".scrollDIV"),
            li = box.find(">div"),
            _w = 200,
            _l = li.length;
        li.each(function (ind, ele) {
            var ele = $(ele),
                _width = (ind == 0) ? 0 : _w * ind;
            //console.log(_width);
            ele.css({
                "left": _width + "px",
                "z-index": ind
            });
        })

        box.bind("mousemove.com", function (e) {
            var _l = e.pageX,
                _w = Math.abs(box.outerWidth() / 5);
            //console.log(_w);
        })
    }
}

//----------------------------------------扩展方法---------------------------------------------
//Array.prototype.remove = function (from, to) {

//    var rest = this.slice((to || from) + 1 || this.length);
//    this.length = from < 0 ? this.length + from : from;
//    return this.push.apply(this, rest);
//};


function ShowValidateTooltip(selector, content) {
    $(selector).tooltip({ showEvent: 'mouseenter', hideEvent: 'mouseenter', content: content }).tooltip('show');
    setTimeout(function () {
        $(selector).tooltip("hide");
    }, 3000);
}
function ShowOverTooltip(selector, content) {
    $(selector).tooltip({ showEvent: 'mouseenter', hideEvent: 'mouseenter', content: content }).tooltip('show');
    return false;
}
function HideMouseOutTooltip(selector, content) {
    $(selector).tooltip("hide");
    return false;
}


/// js类说明：上传通用函数
/// 编 码 人：于驭龙
window["gfccydx"] =
{
    GetUploader: function (event, Success, option) {
        option = option || {};
        var tt = arguments[3] && true;
        iss.upload({
            // "debug":true,
            "fileSizeLimit": "1GB",               //大小
            "queueSizeLimit": 5,                   //一个队列上传文件数限制  
            "removeTimeout": 1,                     //完成时清除队列显示秒数,默认3秒  
            "fileTypeExts": option.FileExt || "*.*",
            "fileTypeDesc": option.FileDesc || "请选择文件",
            "uploader": event.data.url,
            "formData": event.data.uploadData,
            "multi": false,
            "removeCompleted": true,
            "onUploadSuccess": Success,
            "onSWFReady": function () {
                if (tt) { return } else {
                    self_Fun.Event_open(this);
                }
            },
            "onSelect": function (e) {

                $(".error-info").css("background", "url(/Content/images/loading5.gif) no-repeat center center");
                if (e.name.length >= 60) {
                    alert("<span style='font-size:10px;color:#ccc'>" + e.name + "</span>:<span class='red'>名称超过最大60个字符限制！</span>")
                    var ids = this["wrapper"]["selector"];
                    $(ids).uploadify('cancel', e.id)
                    //console.log(e.id);
                    return false;
                }
            }, "onUploadError": function (f, c, m, s) {

                //                console.log(m);
            }
        });
    }
};


var self_Upload = {
    Event_load: function (data) {
        $(".error-info").css("background-image", "none");
        var pid = iss.data("$pid"),
           da = "上传完成！";

        // iss.data("tem_json", da);
        // pid.find(".error-info").html(iss.data("tem_json"));
        //  iss.data("opens") ? (iss.data("opens")).document.write(iss.data("tem_json")) : "";
        //  console.log(data);

        if (data["ExcelSuccessList"].length) {

            (data.ExcelSuccessList[0].search(/^[13]/ig) >= 0) ? (function () {

                da = "<div class='error_block'><h6 class='error_h6 red'>模板错误：</h6><p>" + data.ExcelSuccessList[0].replace(/\d*[\s\S]#+/ig, "") + "</p>";
            }()) : (function () {
                da = "<div class='error_block'>";
                for (var i = 0 ; i < data.ExcelSuccessList.length; i++) {
                    var str = data.ExcelSuccessList[i],
                        num = str.indexOf("#"),
                        stop = str.indexOf("#", num + 1)
                    _top = str.substr(num, stop).replace(/#/ig, "");
                    col = str.substring(stop + 1, str.indexOf("列") + 1);
                    str = str.substr(str.indexOf("列") + 1)
                    da += "<h6 class='error_h6 red'>" + _top + ":   " + col + "</h6><p>" + str + "</p>";

                }
            }());
        }

        iss.data("tem_json", da + "</div>");
        pid.find(".error-info").html(da + "</div>");



    }
}






//----------------------------------------业务逻辑函数------------------------------------------------------
function ShowUploadDialog(obj, excelId) {
    //console.log(Doctype);
    art.dialog.open('/ProjectDoc/UpLoadFile/?ExcelId=' + excelId, {
        title: "上传文件",
        lock: true,
        opacity: 0.5,
        resize: false,
        width: 500,
        height: 300,
        drag: false,
        close: function () {
            var attcontainer = $(obj).closest("div#divattachment");
            if (attcontainer.length == 0)
                window.location = window.location;
        }
    });
}

function CommonFrozenTask(taskid, isall, isfrozen, callback) {
    $.ajax({
        async: false,
        data: { TaskID: taskid, IsAll: isall, IsFrozen: isfrozen },
        url: '/Task/ChangeWorkItemFrozenStatus',//'@Url.Action("ChangeWorkItemFrozenStatus", "Task")',
        type: "POST",
        dataType: "json",
        success: function (result) {
            if (result.Success) {
                if (callback) {
                    callback.call(this, result);
                }
            }
            else {
                iss.dialog.error(result.Msg);
            }
        }
    });
}

function DownloadFile(ID, fileType, isOfficial) {
    //window.open("/ProjectDoc/DownloadFile?ID=" + ID + "&fileType=" + fileType);
    //main_js.Ldownload("/ProjectDoc/DownloadFile?ID=" + ID + "&fileType=" + fileType, {});
    DownLoad("/ProjectDoc/DownloadFile?ID=" + ID + "&fileType=" + fileType + "&isOfficial=" + isOfficial);
}
function DownLoad(strUrl) {
    var form = $("<form>");   //定义一个form表单
    form.attr('style', 'display:none');   //在form表单中添加查询参数
    form.attr('target', '');
    form.attr('method', 'post');
    form.attr('action', strUrl);

    var input1 = $('<input>');
    input1.attr('type', 'hidden');
    input1.attr('name', 'strUrl');
    input1.attr('value', strUrl);
    $('body').append(form);  //将表单放置在web中 
    form.append(input1);   //将查询参数控件提交到表单上
    form.submit();

}

//Modify by diyaguang 2015.4.17 增加下载数据源类型参数 IsOfficial，1审批中，2正式
function GetSummaryStatus(taskID, isOfficial, callback) {
    $.ajax({
        async: false,
        data: { TaskID: taskID, IsOfficial: isOfficial },
        url: '/TaskSummary/GetSummaryExcelStatus?time=' + new Date(),
        type: "POST",
        dataType: "json",
        success: function (result) {
            if (result.Success) {
                if (callback) {
                    //console.log(callback);
                    //result.Data.isFileExist = true;
                    callback.call(this, result.Data);
                }
            }
            else {
                iss.dialog.error(result.Msg);
            }
        }
    });
}

function DownloadSummaryFile(taskID, isOfficial) {
    //Modify by diyaguang 2015.4.17 增加数据源类型参数 isOfficial
    GetSummaryStatus(taskID, isOfficial, function (data) {
        if (data.isUpdated && data.isFileExist) {
            iss.dialog.alert({
                title: "提示", content: "数据已经发生更新，确定要下载之前的汇总数据吗？", ok: function () {
                    DownloadFile(taskID, 'summary', isOfficial);
                }, cancel: true
            });
            return;
        }

        switch (data.status) {
            case 0:
            case 1:
                if (data.isFileExist) {
                    iss.dialog.alert({
                        title: "提示", content: "数据正在汇总中，确定要下载之前的汇总数据吗？", ok: function () {
                            DownloadFile(taskID, 'summary', isOfficial);
                        }, cancel: true
                    });
                }
                else {
                    window.top.iss.dialog.alert("没能找到汇总文件");
                }
                break;
            case 2:
            case 3:
                if (data.isFileExist) {
                    DownloadFile(taskID, 'summary', isOfficial);
                }
                else {
                    window.top.iss.dialog.alert("没能找到汇总文件");
                }
                break;
            case -1:
                window.top.iss.dialog.alert("汇总出错，请联系管理员");
                break;
        }
    });
}

//Modify by diyaguang 2015.4.16 新增 taskType参数，用来区分汇总的类型，0为平台或片区汇总，1为大区或集团汇总。
//类型为0的汇总，只汇总自己的数据，类型为1的汇总要汇正式的数据和审批中的数据。
function OnSummaryStatusChanged(taskID, taskType) {
    //Add by diyaguang 2015.4.17 增加参数 isOfficial 设置数据源，这里默认为0，或着为2，1的情况表示审批中，只有在汇总下载页面中才用到
    var isOfficial = 0;
    //console.log(taskType);
    if (taskType === 1)
        isOfficial = 2;

    var Controller = {
        BtnSummary: function (enabled) {
            if (enabled) {
                $("#btnSummary").off("click");
                $("#btnSummary").on("click", function () {

                    //Add by diyaguang 2015.4.24 增加Btn的属性，设置汇总类型
                    var pageTaskType = $(this).attr("tasktype");


                    iss.dialog.loading();
                    //数据抽取并弹出匹配页面
                    $.ajax({
                        data: {
                            TaskID: taskID,
                        },
                        url: '/ExtractMatching/GetTaskInfoByTaskId?time=' + new Date(),
                        type: "POST",
                        dataType: "json",
                        success: function (result) {
                            //alert(result.OrgID + "\n" + result.WorkStepID)
                            var stepId = result.WorkStepID;
                            var orgId = result.OrgID;
                            //var stepId = "744525ef48534b63b2ed78b560674bb2";
                            //var orgId = "c2a69d835abc4960b3a675fe8cf8a72c";
                            var url = '/ExtractMatching/ExtractData';
                            $.ajax({
                                url: url,
                                type: "get",
                                data: { stepId: stepId, orgid: orgId },
                                success: function (data) {
                                    console.log(data);
                                    if (data.Success == true) {
                                        $.ajax({
                                            url: "/ExtractMatching/IsJumpMatchPage?orgId=" + orgId,
                                            type: "get",
                                            success: function (data) {
                                                if (data.Success == true) {
                                                    if (confirm("抽取完成!是否跳转到匹配页面？")) {
                                                        var eurl = '/ExtractMatching/Index?orgId=' + orgId + '&stepId=' + stepId + '&taskId=' + taskID;
                                                        window.open(eurl);
                                                    }
                                                }
                                            },
                                            error: function (x,y,z) {
                                                alert("请求跳转失败！");
                                            }
                                        })
                                    }
                                    else {
                                        iss.dialog.alert({
                                            title: "错误提示",
                                            content: "数据抽取出错：" + data.Msg
                                        });
                                    }
                                },
                                error: function (x, y, z) {
                                    alert("数据抽取请求失败！");
                                }
                            })
                        }, error: function (x, y, zs) {
                            alert("其他请求失败！");
                        }
                    });


                    $.ajax({
                        async: false,
                        data: {
                            TaskID: taskID,
                            TaskType: taskType   //add by diyaguang 2015.4.17 增加类型参数，区分总部或平台
                        },
                        url: '/TaskSummary/AddSummaryExcelTask?time=' + new Date(),
                        type: "POST",
                        dataType: "json",
                        success: function (result) {
                            if (result.Success) {
                                OnSummaryStatusChanged(taskID, pageTaskType);  //Modify by diyaguang 2015.4.16 增加 taskType 参数
                            }
                            else {
                                iss.dialog.error(result.Msg);
                            }
                            setTimeout(function () {
                                iss.dialog.loading.close();
                            }, 300)
                            setTimeout(function () {
                                try {
                                    iss.dialog.loading.close();
                                } catch (e) { }
                            }, 3000)
                        }
                    });

                });
                $("#btnSummary").removeAttr("disabled", "disabled");
            }
            else {
                $("#btnSummary").off("click");
                $("#btnSummary").attr("disabled", "disabled");
            }
        },
        BtnApproval: function (enabled) {
            if (enabled) {
                $("#btnApproval").on("click");
                $("#btnApproval").removeAttr("disabled", "disabled");
            }
            else {
                $("#btnApproval").off("click");
                $("#btnApproval").attr("disabled", "disabled")
            }
        },
        BtnSummaryDownload: function (enabled) {
            if (enabled) {
                $("#btnSummaryDowload").off("click");
                $("#btnSummaryDowload").on("click", function () {
                    //Add by diyaguang 2015.5.18 增加下载类型参数
                    var downloadtype = $(this).attr("downloadtype");
                    //Modify by diyaguang 2015.4.17 增加下载类型参数，用在下发或上报页面中
                    //Modify by diayguang 2015.5.18 修改下载类型参数，0临时数据，2正式数据
                    DownloadSummaryFile(taskID, downloadtype);
                });
                $("#btnSummaryDowload").removeAttr("disabled", "disabled");
            }
            else {
                $("#btnSummaryDowload").off("click");
                $("#btnSummaryDowload").attr("disabled", "disabled");
            }
        }
    }

    GetSummaryStatus(taskID, isOfficial, function (data) {
        if (!data.isFinanceSubjectPassed) {
            $("#sumInformation").html("财务科目未达标，不能提报审批");
            switch (data.status) {
                case -1:
                case 0:
                case 2:
                case 3:
                    $("#btnSummary").val("汇总");
                    Controller.BtnSummary(true);
                    break;
                case 1:
                    $("#btnSummary").val("汇总中");
                    Controller.BtnSummary(false);
                    break;
            }
            Controller.BtnApproval(false);
            Controller.BtnSummaryDownload(data.isSummaried);
            return;
        }
        //优先判断汇总中
        if (data.status == 1) {
            $("#btnSummary").val("汇总中");
            $("#sumInformation").html("数据汇总中请点击<a href='javascript:;'  class='red J_tip' onclick='location.reload()' >刷新</a>页面");
            Controller.BtnSummary(false);
            //Controller.BtnApproval(false);
            Controller.BtnSummaryDownload(data.isSummaried);
        }
        else if (data.isUpdated) {
            $("#sumInformation").html("数据已更新，请重新汇总和提报");
            if (!data.isReportable) {
                //Controller.BtnApproval(true);
            }
            else {
                //Controller.BtnApproval(false);
            }
            Controller.BtnSummary(true);
            Controller.BtnSummaryDownload(data.isSummaried);
        }
        else {

            switch (data.status) {
                case -1: //汇总失败
                    $("#sumInformation").html("数据汇总失败，汇总时间：" + data.SummaryTime);
                    $("#btnSummary").val("汇总");
                    Controller.BtnSummary(true);
                    //Controller.BtnApproval(false);
                    Controller.BtnSummaryDownload(data.isSummaried);
                    break;
                case 0: //未汇总
                    $("#sumInformation").html("数据未汇总，请先汇总后再点击下载和提报");
                    $("#btnSummary").val("汇总");
                    Controller.BtnSummary(true);
                    //Controller.BtnApproval(false);
                    Controller.BtnSummaryDownload(data.isSummaried);
                    break;
                case 1: //汇总中
                    $("#btnSummary").val("汇总中");
                    $("#sumInformation").html("数据汇总中请点击<a href='javascript:;'  class='red J_tip' onclick='location.reload()' >刷新</a>页面")
                    Controller.BtnSummary(false);
                    //Controller.BtnApproval(false);
                    Controller.BtnSummaryDownload(data.isSummaried);
                    break;
                case 2: //汇总完成
                    //提报
                    //alert(data.SummaryTime);
                    $("#sumInformation").html("数据汇总已完成，汇总时间：" + data.SummaryTime);
                    $("#btnSummary").val("汇总");
                    Controller.BtnSummary(true);
                    //Controller.BtnApproval(true);
                    Controller.BtnSummaryDownload(data.isSummaried);
                    break;
                case 3: //已提报
                    $("#sumInformation").html("数据已经提报");
                    $("#btnSummary").val("汇总");
                    Controller.BtnSummary(true);
                    //Controller.BtnApproval(false);
                    Controller.BtnSummaryDownload(data.isSummaried);
                    break;
            }
        }
    });
}

(function (widnow) {

    window.alert = function (a, b) {
        window.top.iss.dialog.alert({
            title: "提示",
            content: a ? a : "请输入提示消息",
            ok: function () {
                b && (b());
                //try{
                window.top.iss.dialog.close();
                // }catch(e){}
            }
        });

    }

})(window)
//----------------------------------------实际值上报导出datagrid by 甄丹彤------------------------------------------------------

function ExportDataGridToExcel(divID, targetName, trueValue) {
    var values = $.data($(divID)[0], "datagrid").data;
    if (trueValue != null) {
        values = trueValue;
    }
    $.post("/ActValReport/ExportValues?time=" + new Date().getTime(),
        { cols: JSON.stringify($.data($(divID)[0], "datagrid").options.columns), rols: JSON.stringify(values), TargetName: targetName, OrgName: $("#selOraganizationText").val() },
        function (fileName) {
            if (fileName != "") {
                location.href = '/ActValReport/DownloadFiles?fileName=' + fileName + '&time=' + new Date().getTime();
            } else {
                alert("没有需要导出的数据！");
            }
        }
    );
}

function getOldValue(submitPeriod, factTime, targetID, orgID) {
    $.ajax({
        url: '/ActValReport/GetOldValueForCommonTarget?submitPeriod=' + submitPeriod + '&factTime=' + factTime + '&targetID=' + targetID + '&orgID=' + orgID,
        type: "POST",
        async: false,
        dataType: "json",
        success: function (result) {
            if (result.ID != "") {
                $("#ID").val(result.ID);
                $("#Amount").val(result.Amount);
                $("#Field1").val(result.Field1);
                $("#Field2").val(result.Field2);
                $("#Field3").val(result.Field3);
                $("#Field4").val(result.Field4);
                $("#Field5").val(result.Field5);
                $("#Field6").val(result.Field6);
                $("#Field7").val(result.Field7);
                $("#Field8").val(result.Field8);
                $("#Remark").val(result.Remark);
            } else {
                $("#ID").val("");
                $("#Amount").val("");
                $("#Field1").val("");
                $("#Field2").val("");
                $("#Field3").val("");
                $("#Field4").val("");
                $("#Field5").val("");
                $("#Field6").val("");
                $("#Field7").val("");
                $("#Field8").val("");
                $("#Remark").val("");
            }

        }
    });
}