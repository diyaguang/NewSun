/**
 * [软通华夏项目js控件框架v0.1]
 * @param  {[type]} $      [全局$引用]
 * @param  {[type]} window [全局window引用]
 * @return {[type]}        [返回自身引用]
 * @author {[name]  [zxma@isoftstone.com]}
 * @description {此框架融入很多外部控件，对于版本在开发中更新，有修改请在此标注！分享}
 */
;
(function ($, window) {

    var doc = document,
		body = (document.compatMode.toLowerCase() === "css1compat") ? $(document.documentElement) : $(document.body),
		win = $(window),
        $doc = $(document),
		console = window.console || {},
		tableArg,
		ISS_SROUCE_URL = "/Scripts/source/";  //页面引入js资源地址配置，可更换

    var iss = {

        //最小页面宽度判断工具
        //1、iss.minwindow(".J_minwindow",960)
        //2、iss.minwindow()   
        //说明：可以无参数默认判断元素为J_minwindow，值为1000
        //参数1   需要判断最小宽度的元素
        //参数2	  最小值
        minwindow: function (ele, num) {

            win.bind("resize.win load.win", function () {
                var
					width = parseInt(num) ? parseInt(num) : 1000,
					_w = (body.outerWidth() <= width) ? width + "px" : "auto";
                ((ele && $(ele)) || $(".J_minwindow")).css("width", _w);

            });
            return this;

        },
        // 最小高度判断工具
        //1、iss.minheight(".J_minwindow",960)
        //2、iss.minheight()
        //3、iss.minheight(".xxx")
        //4、iss.minheight(300)   
        //说明：可以无参数默认判断元素为J_minheight，如果不设置参数则默认为元素J_minheight的高度为460；
        //参数1   需要在加载时设置最小高度的元素id或class，如果为空则默认设置元素为J_minheight
        //参数2	  设置在加载时设置的值，如果为空则默认为460px高
        minheight: function (ele, num) {
            win.bind("load.win", function () {

                var
					_ele = (ele && typeof ele === "string") ? $(ele) : $(".J_minheight"),

					height = (ele && typeof ele === "number" || parseInt(ele)) ?
					parseInt(ele) : num ? parseInt(num) : 460 /*(body.outerHeight()>460)? body.outerHeight():460*/,

					_h = (ele && typeof ele === "string" && !parseInt(ele) === "number") ? _ele.outerHeight() : height;
                _ele.css("height", _h + "px");



            });
            return this;
        },
        //通用最小高度和宽度的默认值
        autowindow: function () {
            var self = this;
            self.minwindow();
            self.minheight();
            return this;
        },
        /**
		 *iframe高度自适应
		 *iss.autoIframeHeight()
		 */
        autoIframeHeight: function () {
            var th = this;
            if (window.parent == window.self) { return };
            //setTimeout(function(){

            var
            body = th.compat ? document.body : document.documentElement,
            top = window.parent,
            _h = Math.max(body.scrollHeight, body.offsetHeight),
            _t = "iframe_" + new Date().getTime();
            window.navigator.name = _t;
            var ele = top.document.getElementsByTagName("iframe");
            for (var i = 0; i < ele.length ; i++) {
                if (ele[i].contentWindow && ele[i].contentWindow.navigator.name == _t) {

                    // console.log(body.scrollHeight);
                    var names = ele[i].name;
                    if (names && window.top.iss.dialog.list[names]) {
                        ele[i].scrolling = "no";
                        ele[i].contentWindow.document.body.style.overflow = "hidden";
                        window.top.iss.dialog.list[names].size(null, _h);
                        return
                    }


                    ele[i].setAttribute("height", _h);
                    //console.log(_h);
                }
            }
            //});

        },
        //隔行变色，要求table必须含有tbody,隔行变色的为参数的子元素和tbale的tbody里的tr元素 
        //1、iss.tableodd(".table,.ul")
        //2、iss.tableodd(".table")
        tableodd: function (arg) {

            var arg = arg.split(","),
				sear = "tbody tr:odd";
            $.each(arg, function (ind, ele) {
                var e = $(ele),
					n = e[0].nodeName.toLowerCase();
                sear = (n === "table") ? e.find(sear) : e.find(">*:odd");
                sear.addClass("tr-odd");
            })


        },
        slideBox: function () {
         
            $(".iss-slideBox").each(function (ind, ele) {
                var th = $(ele),
                    tp = th.parent(),
                    wap = $("<div class='iss-wap-slideBox'></div>");
                    tp.append(wap).append("<span class='iss-slideBox-bar'></span>");
                    //wap.append(th);
                     th.css({"overflow-x":"hidden","overflwo-y":"auto"});
                    
              
            });
            $doc.on("click", ".iss-slideBox-bar", function () {
                var self = $(this);

            })
        },
        //锁定表头全局命名
        table: function (arg) {

            var self = this;
            self.getQ("iss-table", arg);
            return this;
        },
        /**
		 * [tabs 标签页控件]
		 * js: iss.tabs()
		 * html: <div class="iss-tabs" ><div title="标签1" >1</div><div title="标签2">2
        </div>
        <div title="标签3">
            3
        </div>
    </div>
		 */
        tabs: function () {
            var self = this;
            var tabs = $(".iss-tabs:not([data-type='true'])");
            tabs.each(function (i, e) {
                var _e = e.childNodes,
					i = 0,
					de = 0,
					ele = 1,
					linum = "",
					_t = '<ul class="iss-tabs-nav">';
                (!e.getAttribute("data-type")) && e.setAttribute("data-type", "true");
                for (; i < _e.length; i++) {
                   
                    if (_e[i].nodeType === 1) {
                        (ele == 1) && (function () {
                            ele = _e[i];
                            linum = " on fist"
                        })();
                        (_e[i].className.indexOf("on") >= 0) ? de = 0 : de = 1;
                        var ti = _e[i].title,
                         ev = (_e[i].getAttribute("event"))? _e[i].getAttribute("event"):"";
                        _e[i].className += "iss_tabls_child iss_tabls_div" + i;
                        _t += '<li class="iss_tabs_li' + i + linum + '" event='+ev+'>' + ti + '</li>';
                        linum = "";
                    }
                }
                de && (ele.className += " on");
                _t += "</ul>";

                $(e).prepend(_t);
                var ee = $(ele);
                (ee.find("table").length) && setTimeout(function () { self.gruid(ee) }, 100);
            });
            $(".iss-tabs").off("click.iss").on("click.iss", ".iss-tabs-nav li", function () {
                var th = $(this),
					pa = th.closest(".iss-tabs"),
					pa_on = pa.find(".on"),
					ind = th.index(),
                    eles = pa.find(".iss_tabls_child:eq(" + ind + ")").addClass("on");
                if (eles.attr("off") == "true") { return;}
                pa_on.removeClass("on");
                th.addClass("on");
            
                
                setTimeout(function () {
                    self.gruid(eles);
                  
                 
                });
               
                // if (th.attr("one")==null&&th.attr("event")) {
                if (th.attr("event")) {
                    // th.attr("one", "true");
                    // console.log(th.attr("one"))
                    eval(th.attr("event"));
                }
            });

        },
        //针对esayUI对应tabs控件不能获取高度的补救措施，由tabs内部调用
        gruid: function (arg) {

            var ele = $(arg).find("table");
            if (arg.attr("data-default") == "true") { return };
            arg.attr("data-default", "true");
            if (ele.hasClass("treegrid")) {
                ele.treegrid();
            } else if (ele.hasClass("datagrid")) {
                ele.datagrid();
            }

        },
        //判断浏览器模式怪异和正常
        compat: function () {
            var mode = document.compatMode;
            if (mode.search(/css/ig) >= 0) {
                return true
            } else { return false }
        },
        /**
		 * [setTime 倒计时]
		 * @param {[type]} obj [description]
		 *  倒计时,time= 毫秒数 iss.setTime("2014/9/30 23:59:59-2014/8/15 14:47:13");
		    参数为服务器开始时间与结束时间
		    iss.setTime({ "time": "2014/8/15 17:49:32-2014/8/15 18:00:32", "day": ".issd", "hour": ".issh", "minute": ".issm", "second": ".isss" });
		 */
        setTime: function (obj) {

            if (!obj) { return }
            var date = obj.time.split("-"),
				ent = new Date(date[0]),
				sat = new Date(date[1]),
				x = ent.getTime() - sat.getTime();
            //alert(x);
            if (x <= 0) { return }
            var lend = new Date().getTime() + x;

            var setT = setInterval(function () {
                var cur = new Date().getTime(),
                    tract = lend - cur;
                if (tract <= 0) {
                    clearInterval(setT);
                    $(obj.day).html("结束")
                    return;
                };
                var dp = 24 * 3600 * 1000,
                    hp = 3600 * 1000,
                    mp = 60 * 1000,
                    _d = Math.floor(tract / dp),
                    _h_ = tract - _d * dp,
                    _h = Math.floor(_h_ / hp),
                    _m_ = _h_ - _h * hp,
                    _m = Math.floor(_m_ / mp),
                    _s_ = _m_ - _m * mp,
                    _s = Math.floor(_s_ / 1000);
                //console.log(_d+"天"+_h+"小时"+_m+"分"+_s+"秒");
                $(obj.day).html((_d <= 0) ? 0 : _d<10? "0"+_d:_d);
                $(obj.hour).html((_h <= 0) ? 0 : _h<10? "0"+_h:_h);
                $(obj.minute).html((_m <= 0) ? 0 : _m<10? "0"+_m:_m);
                $(obj.second).html((_s <= 0) ? 0 : _s<10? "0"+_s:_s);
            }, 1000);



        },
        outTime: function (val, pram) {
            var da = new Date(val) || "";

        },
        loading: function (arg) {
            //待添加
        },
        dialog: function (arg) {
            // 使用方法
            /*1: iss.dialog.alert("操作成功");
          2: iss.dialog.alert("请求失败",function(){});
          3: iss.dialog.alert(["您不是VIP用户，无权操作","现在开通还有好礼相送哦"],function(){});
a                content:["确定要删除该日志吗？","删除后该日志下的评论也将删除，且不能恢复"],
                ok:function(){
                },
                okValue:"删除",
                cancel:1,
                title:"警告"
            });
          5: iss.dialog.alert({url:"http://ww.hao123.com",ok:false,button:[{id:"iframe弹出",value:"iframe弹出",callback:function(){this.close()}}]})
          6: iss.dialog.error("同目录1")
          7: iss.dialog.success("同目录1")
          8: iss.dialog.warning("同目录1")
          9: iss.dialog.loading("loaing") 
          10:iss.dialog.loading.close("关闭loading")*/

        },
        //上传控件
        //iss.unslider()
        unslider: function (arg) {
            var self = this;
            self.getQ("iss-unslider", arg);
            return this;
        },
        /**
		 * [data 全局变量存取，iframe中自由获取]
		 * 1、iss.data("value")               获取
		 * 1、iss.data("value","设置内容")    设置
		 */
        data: function (arg, val) {

            var self = this,
				win = window.top;

            if (val === undefined) {

                return win.iss._data[arg];
            } else {

                return win.iss._data[arg] = val;


            }
        },
        _data: {},
        //flsah上传控件
        /**
         *iss.upload({
         *  
         *  swf: '/uploadify/uploadify.swf',
         *  uploader: '/uploadify/uploadify.php'
         *  
         *  });
		 */
        upload: function (arg) {

            var self = this;
            self.getQ("iss-uploadify", arg);
            return self;

        },
        /**
         * [validate 验证控件]
         * @param  {[object]} arg [参数]
         * @return {[validate对象]}     [返回validate对象]
         * #FORM
         * 1、 iss.validate({
                        "#FORM": {   //------------------------------form的id或class，jquery对象
                            rules: { //------------------------------规则对象

                                inputName: {//-----------------------表单name

                                    required: true,//----------------必填
                                    test: function (v) {
                                        if (v == "2014-9-26") {
                                            return true
                                        }
                                        return false
                                    }
                                }
                            },
                            messages: {//----------------------------自定义消息提示
                                inputName: {//-----------------------对应上面名称
                                    required: "姓名",//--------------对应rules表单提示
                                    test:自定义消息提示//------------自定义rules提示
                                }
                               
                            }

                        }
                    });
         */
        validate: function (arg) {

            var self = this;
            self.getQ("iss-validate", arg);
            return self;
        },
        /**
		 * [valid 自定义验证]
		 * @return {[type]} []
		 */
        valid: function (arg) {


        },
        //<div class="iss-iframe"></div>
        //iss.iframe()
        //创建iframe并通过加载iframe获取异步数据
        /*iframe:function(src){
			var th = this,
				
			$(".iss-iframe").each(function(ind,ele){
	

			})

		},*/


        /**
		 * [getQ 获取外部js 加载器]
		 * @param  {[type]} quer [description]
		 * @param  {[type]} data [description]
		 * @return {[type]}      [description]
		 * JS命名规则
		 * 外部名称以“iss-”开头后面跟名称
		 * 在_fn中变量会自动去除“-”，获取时应以“issxxx”获取 "iss._fn.issxxx"
		 * 外部js设置全局变量名称应该为“set_issxxx”获取为“iss.set_issxxx”
		 */
        getQ: function (quer, data) {

            var self = this,
				idd = quer.replace(/\-/ig, "");

            if (document.getElementById(idd)) {

                iss["set_" + idd] ? (iss["set_" + idd])(data) : iss._fn[idd].push(data);
            } else {
                var js = document.createElement("script");
                js.id = idd;
                js.src = ISS_SROUCE_URL + quer + ".js?"+ (new Date()).getTime();
                document.getElementsByTagName("head").item(0).appendChild(js);
                iss._fn[idd] = iss._fn[idd] || [];
                iss._fn[idd].push(data);
                delete js;
                // 延时判断是否加载完成
                setTimeout(function () {
                    self.ready(idd)
                }, 500);
            }



            return this;

        },
        /**
		 * [formTable 自动模板生成]
		 * @param [json] 穿入json对象
		 * 1、iss.formTable({[]})
		 * json格式如下
         * {	"Data": {
				"MaxLevel": 3,
				"RowCount": 60,
				"CurrentStep": 0,
				"Option": [{
					"ChName": "单位",
					"Type": "property",
					"EnName": "Unit"
				}, {
					"ChName": "赋分值",
					"Type": "property",
					"EnName": "Score"
				}, {
					"ChName": "一下",
					"Type": "data",
					"EnName": "1-1"
				}, {
					"ChName": "一上",
					"Type": "data",
					"EnName": "1-2"
				}, {
					"ChName": "二下",
					"Type": "data",
					"EnName": "2-1"
				}, {
					"ChName": "二上",
					"Type": "data",
					"EnName": "2-2"
				}, {
					"ChName": "描述",
					"Type": "property",
					"EnName": "Desc"
				}],
				"Subject": [{
					"Level": 1,
					"ID": "0bb709b2d4a24b7a8cab5ea1bb68ffe6",
					"Name": "财务类",
					"Unit": "",
					"Score": null,
					"Desc": "",
					"Data": [null, null, null, null],
					"Children": [{
						"Level": 2,
						"ID": "55786b4e51a1456cb492ad3fb6f3f694",
						"Name": "规模类",
						"Unit": "",
						"Score": null,
						"Desc": "",
						"Data": [null, null, null, null],
						"Children": [{
							"Level": 3,
							"ID": "796357dd0ddc46edb515fd4b57bfea0a",
							"Name": "回款额",
							"Unit": "亿元",
							"Score": 10,
							"Desc": "",
							"Data": [null, null, null, null],
							"Children": []
						}]
					}]
				}]
			},
			"Success": true,
			"ExcelSuccessList": null,
			"Msg": null
        }
		 */
        formTable: function (arg) {
            var self = this;

            self.getQ("iss-formTable", arg);

            return self;

        },
        getC: function (arg) {
            //获取css
        },
        require: function (arg) {
            var
				str = arg.split("."),
				i = 0,
				obj = window;
            for (; i < str.length; i++) {
                obj = obj[str[i]] = obj[str[i]] || {};
            }
            return obj;
        },
        // 判断js是否加载
        ready: function (quer) {
            var self = this;
            self._fn[quer] || alert(quer + "控件未加载！");
            return this;
        },
        // 弹窗私有方法不属于iss全局
        setEven: function (arg) {
            $.each(arg, function (i, e) {
                iss.dialog[e] = function () {
                    // iss.getC(arg);
                     
                    iss.getQ("iss-dialog", [e, arguments]);
                }

            })

        },

        // 全局变量初始化
        _fn: {}

    };
    // 添加弹出窗口方法
    iss.setEven(["alert", "error", "success", "warning", "loading", "confirm"]);

    window["iss"] = iss;

})(jQuery, window);

//原始js重定义


    /* 日期添加format方法重定义*/

(function (window) {


    // 对Date的扩展，将 Date 转化为指定格式的String 
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
    // 例子： 
    // (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
    // (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
    window.Date.prototype.Format = function (fmt) { //author: meizz 
        (!fmt) && (fmt = "yyyy-mm-dd");
        var o = {
            "M+": this.getMonth() + 1,                 //月份 
            "d+": this.getDate(),                    //日 
            "h+": this.getHours(),                   //小时 
            "m+": this.getMinutes(),                 //分 
            "s+": this.getSeconds(),                 //秒 
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
            "S": this.getMilliseconds()             //毫秒 
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

    window.String.prototype.replaceAll = function (reallyDo, replaceWith, ignoreCase) {
        if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
            return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")), replaceWith);
        } else {
            return this.replace(reallyDo, replaceWith);
        }
    }
    //字符串截取
    window.String.prototype.overflow = function (int, replace, title) {
        var str = this.toString(),
            len = int || str.length,
            re = replace || "...",
            ti = title || str;
            
        txt = '<span title="' + str + '">' + str.substr(0, len) + (str.length <= int ? "" : re) + '</span>'
            return txt;
            
    }

    window.Number.prototype.FormatThousand = function (cent) {
        var num = this.toString().replace(/\$|\,/g, '');
        if (isNaN(num))//检查传入数值为数值类型.
            num = "0";
        if (isNaN(cent))//确保传入小数位为数值型数值.
            cent = 0;
        cent = parseInt(cent);
        cent = Math.abs(cent);//求出小数位数,确保为正整数.

        sign = (num == (num = Math.abs(num)));//获取符号(正/负数)
        //Math.floor:返回小于等于其数值参数的最大整数
        num = Math.floor(num * Math.pow(10, cent) + 0.50000000001);//把指定的小数位先转换成整数.多余的小数位四舍五入.
        cents = num % Math.pow(10, cent); //求出小数位数值.
        num = Math.floor(num / Math.pow(10, cent)).toString();//求出整数位数值.
        cents = cents.toString();//把小数位转换成字符串,以便求小数位长度.
        while (cents.length < cent) {//补足小数位到指定的位数.
            cents = "0" + cents;
        }

        //对整数部分进行千分位格式化.
        for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3) ; i++)
            num = num.substring(0, num.length - (4 * i + 3)) + '’' +
            num.substring(num.length - (4 * i + 3));
        return (((sign) ? '' : '-') + num + '.' + cents);
    }

    window.getQueryString = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = location.search.substr(1).match(reg);
        if (r != null) return unescape(decodeURI(r[2])); return null;
    }


    window.getDateTime = function (str) {
        if (str != null && str != "" && str != undefined) {
            var d = new Date(parseInt(str.replace("/Date(", "").replace(")/", ""), 10));
            var time = '';
            var month = parseInt((d.getMonth() + 1)) < 10 ? '0' + (d.getMonth() + 1) : (d.getMonth() + 1);
            var day = parseInt(d.getDate()) < 10 ? '0' + d.getDate() : d.getDate();
            var hours = d.getHours() < 10 ? '0' + d.getHours() : d.getHours();
            var minutes = d.getMinutes() < 10 ? '0' + d.getMinutes() : d.getMinutes();
            var seconds = d.getSeconds() < 10 ? '0' + d.getSeconds() : d.getSeconds();
            time = d.getFullYear() + '-' + month + '-' + day + ' ' + hours + ":" + minutes + ":" + seconds;
            return time;
        } else {
            return "";
        }
    }

    //console重写
    
    var console ={
        log: function (val) {
            return;
            $("#win_log").remove();
            var log = window.open("", "name", "width=400,height=400")
            log.document.write(val);
        }
    
    }

    window.console = window.console ? window.console : console;

})(window);