; (function ($, window) {

    var publicFun = {
        pub2nav: function () {
            $(".head").append($(".breadcrumb"));
        },
        demo: function () {
            var nav = $(".wap_nav>ul"),
                str = '<li> <a href="demo" target="_blank">DEMO(可以点击)</a><ul class="layer">' +
                 '<li><a href="JavaScript:;">以下实例是线上内容请勿修改用admin登陆</a></li>' +
                       '<li><a href="http://10.2.90.34:8081/Project/Index">表格实例</a></li>' +
                        '<li><a href="http://10.2.90.34:8081/BusinessTarget/Index">树形表格实例</a></li>' +
                        '<li><a href="http://10.2.90.34:8081/Menu/">弹窗实例点修改或添加同级</a></li>' +
                       '</ul></li>';
            nav.append(str);
        }
    }


    iss.autowindow();
    iss.tabs();
    iss.slideBox();//收缩框
    publicFun.pub2nav();//全局二级导航引入顶部
    publicFun.demo();//添加demo
})(jQuery, window);

//二期开发
; (function ($, window) {
    var win = $(window),
        doc = $(document);
    $.fn.extend({
        /*
            $("input").parseInput({type:'int'}); 
            参数  值             类型        说明
            type: int||number    string      浮点类型或正整数
            dec:  4              int         可选，与浮点捆绑的小数位数，默认4位
        */
        parseInput: function (arg) {
            var th = $(this),
                opt = {
                    'type': 'number',//int 两种类型，默认为number
                    'dec': 4//保留小数位，默认为4位
                }
            if (arg && !arg["dec"]) { opt.dec = 12 }
             arg && ($.extend(opt, arg));
            th.bind('keyup.iss', function () {
                var self = $(this),
                    val = self.val();
                reg = /^\d*\.?\d*$/ig,
                reg_num = /[^\d|\.]/ig,
                reg_num2 = new RegExp("\\d*\\.?(?:\\d{0," + opt.dec + "})", "i"),
                reg_num3 = new RegExp("\\d{0," + opt.dec + "}", "i");
               
                if (opt.type === 'number') {


                    if (!reg.test(val)) {
                        var str = val.replace(reg_num, "")
                                     .match(reg_num2);
                        self.val(str[0]);
                    } else {
                        var str2 = val.match(reg_num2);
                        //console.log(str2[0]);
                        self.val(str2)
                    }

                } else if (opt.type === "int") {
                   
                    if (val.length >= opt.dec) {
                        self.val(val.replace(/\D/ig, "").match(reg_num3)[0]);
                    } else {

                        self.val(val.replace(/\D/ig, ""));
                    }
                }

            })
           
        },
        DateSelect: function (arg) {
            var str = "<div class='quarter'><p><input class='q_input' readonly='readonly' /><span class='q_icon'></span></p></div>";
            q_Level1 = "<ul class='q_Level1'>",
            q_Level2 = '<ul class="q_Level2">',
          
            i = 0,j=0,f=0,
            date = new Date(),
            th = $(this),
            opt = {
                min: date.getFullYear() - 4,
                max: date.getFullYear() + 4,
                onChange: $.noop,
                leve: 3,
                start:1
            },
             setHTML = function () {
                    
             },
             Event_mouseenter = function () {

             },
             remove = function () {
                 var arg = arguments;
                 for (var v = 0; v < arg.length; v++)
                 {
                     arg[v].remove();
                 }
             }
            $.extend(opt, arg);
            th.css({"height":"1px","border":"none","font-size":"0", "visibility": "hidden","width":"0","padding":"0","margin":"0","text-indent":"0" }).after(str);

            //设置年
            for (i = opt.min; i < opt.max; i++) {
                      
                q_Level1 += '<li><p><a href="javascript:;" class="q_yer" >' + i+ '年</a>'+((parseInt(opt.leve)>1)? '<span class="q_yer_span">季度</span>':"")+'</p></li>';
            }
            q_Level1 += "</ul>";
            //设置季度
            for (; j < 4; j++) {
                q_Level2 += '<li><p><a href="javascript:;" class="q_quarter" >' + (j+1) + '季度</a>'+((parseInt(opt.leve)>2)? '<span class="q_quarter_span">月</span>':"")+'</p></li>';
            }
            q_Level2 += '</ul>';
            //设置月
            var setMon = function (arg) {
               
                var tt = parseInt(arg),
                    q_Level3 = '<ul class="q_Level3">',
                    tt = tt == 1 ? 1 : tt == 2 ? 4 : tt == 3 ? 7 : tt == 4 ? 10 : 12;

                for (var ss = 0; ss < 3; ss++) {
                    q_Level3+= '<li><p><a href="javascript:;" class="q_mon">' + (tt++) + '月</a></p>';
                }
              
                return q_Level3 += '</ul>';
           
                
                
            }
           
           
            doc.on("click",function (ev) {
                var This = $(ev.target),
                    Parent = This.parent().parent(),
                    Level1 = $(".q_Level1"),
                    Level2 = $(".q_Level2"),
                    Level3 = $(".q_Level3"),
                    input = (Parent.hasClass("quarter")) ? Parent.find("input.q_input") : Parent.closest(".quarter").find("input.q_input");
                   
                if (This.hasClass("q_icon")) {
                    $(".quarter.on").removeClass("on");
                    remove(Level1, Level2, Level3);
                    if (opt.start && opt.start == 1) {
                        Parent.append(q_Level1).addClass("on")
                    } else if (opt.start == 2) {
                        Parent.append(q_Level1).addClass("on")
                    }
                   

                    return;
                } else if (This.hasClass("q_yer_span")) {
                    Parent.parent().find(".on").removeClass("on");
                    remove(Level2, Level3);
                    Parent.append(q_Level2).addClass("on");
                    input.data("date-fn-yer",This.prev().text())
                   
                    return;
                } else if (This.hasClass("q_quarter_span")) {
                    Parent.parent().find(".on").removeClass("on");
                    remove(Level3);
                    Parent.append( setMon(This.prev().text())).addClass("on");
                    input.data("date-fn-quart",This.prev().text());
                    return;
                } else if (This.hasClass("q_yer")) {
                    input.val(This.text());
                    opt.onChange(This.text());
                    th.val(This.text())
                    //return;
                } else if (This.hasClass("q_quarter")) {
                    var q_q_t = input.data("date-fn-yer")? input.data("date-fn-yer")+"/":"";
                    input.val(q_q_t + This.text());
                    opt.onChange( q_q_t+ This.text());
                    th.val(q_q_t+ This.text())
                } else if (This.hasClass("q_mon")) {
                    var q_m_t = input.data("date-fn-yer") ? input.data("date-fn-yer") + "/" : "";
                    input.val(q_m_t + input.data("date-fn-quart") + "/" + This.text());
                    opt.onChange(q_m_t + input.data("date-fn-quart") + "/" + This.text());
                    th.val(q_m_t + input.data("date-fn-quart") + "/" + This.text());
        }
             
                remove(Level1, Level2, Level3);
            })
         
        }
    })

})(jQuery, window)

//esauUI扩展
; (function ($, window) {
    var win = $(window),
         doc = $(document);
    $.fn.extend({
        /*
        日期格式化到月
        $("xxx").DateBox({}) 
        参数：同esayui的datebox
        附加参数    类型            实例 同ajax回调
        Select      function        { Select:function( self,yer,mon ){  self--> 返回$(this)  ,yer-->年, mon-->月     } }
        */
        DateBox: function (arg) {
            var self = $(this),
                tar,
                opt = {
                    onShowPanel: function () {
                        var ts = this;
                        tar = self.combo("panel");
                        setTimeout(function () {
                           tar.find(".calendar-title span").click();
                        })
                        tar.on("mousedown", ".calendar-menu-month", function () {
                            var th = $(this),
                                mon = th.attr("abbr");
                            yer = tar.find(".calendar-menu-year").val();
                            self.datebox('setValue', mon + "/1/" + yer);
                            self.combo("hidePanel");
                            opt.Select(self, yer, mon);
                        })
                    },
                    formatter: function (date) {
                      
                        return date.getFullYear() +"-"+(date.getMonth()+1);

                    },
                    Select: function (self,yer,mon) {
                        //选取后回调
                        console.log(yer + ":" + mon);
                    }
                    
                }
            $.extend(opt, arg);
            self.datebox(opt);
            
            
            
        }
    })


})(jQuery, window)