
/**
 * 20140820
 * 弹出层插件
 * @memberOf iss
 * @namespace iss.dialog
 * @description 支持弹出层，扩展有成功，错误，警告简单tips，loading等待层，不支持吸附元素，吸附请用 $.fn.tips，优雅的采用糖饼内核, 细节用法请看 https://github.com/aui/artDialog
 * @date 20131227
 * @copyright 软通
 * @author xieliang
 * @email xieyaowu@meishichina.com/zxm@iisoftstone.com
 * @by 20140220     去操作用户焦点
 *                  优化代码
 * @by 20140225     优化 iss.dialog.success,error,warning
 *
 * @add
 *     1, 添加v6事件的支持
 *         on("close")//关闭
 *         on("visible")//显示
 *         on("hidden")//隐藏
 *
 * @example
 *     1, 模拟alert
 *        iss.dialog.alert("你好，这里是美食天下", function(){alert("已经关闭")});
 *     2, 复杂alert
 *         iss.dialog.alert({
 *         
 *             content:["您确定删除这篇日志吗？","删除后相关照片也会删除"],//如果为array则0为大标题，1为副标题
 *             ok:function(){
 *                 //确定按钮回调
 *             },
 *             cancel:function(){},//取消回调
 *             title:"警告"//标题，如果没有则不显示标题
 *         });
 *      3, 支持各种复杂alert，各种按钮，各种显示，各种事件
 *      4, 简单提示
 *          iss.dialog.success  成功
 *          iss.dialog.error    错误
 *          iss.dialog.warning  警告
            iss.dialog.confirm  带是否返回值的提示
 *          三个方法用法相同：
 *              iss.dialog.success("操作已成功",3000);//提示文字，3秒后消失
 *              iss.dialog.error("操作已成功");//默认为2秒
 *              iss.dialog.success("操作成功",function(){alert(1)});//提示文字，关闭后回调
            第四个为
               iss.dialog.confirm("提示"，function(){},function(){})//后两个参数可配置 
 *       5, loading层
 *           iss.dialog.loading();//该层会遮罩起屏幕，并不可用户手动关闭
 *           iss.dialog.loading.close();//关闭loading层，不管是否存在都不会报错
 *       6,  iss.dialog.alert("这是我的时候",function(){
 *               iss.dialog.alert({
 *                   content:["标题","这里注掉是因为下面还是会判断的，这里是如果为<br>字符串就让其fixed，但项目中用不到，so"],
 *                   cancel:function(){
 *                       iss.dialog.error("失败")
 *                   },
 *               cancelValue:"测试",
 *               ok:function(){
 *                   iss.dialog.success("成功",function(){
 *                       iss.dialog.alert({
 *                           width:"auto",
 *                           button:[
 *                               {
 *                                   id:"ce",
 *                                   value:"你好",
 *                                   disabled:!0
 *                               },
 *                               {
 *                                   id:"ce2",
 *                                   value:"我好",
 *                                   focus:!0,
 *                                   highlight:!0
 *                               },
 *                               {
 *                                   id:"ce42",
 *                                   value:"大家好",
 *                                   focus:!0,
 *                                   highlight:!0
 *                               },
 *                               {
 *                                   id:"ce424",
 *                                   value:"大家好",
 *                                   focus:!0,
 *                                   disabled:!0
 *                               },
 *                               {
 *                                   id:"ce4d24",
 *                                   value:"大家好",
 *                                   focus:!0,
 *                                   highlight:!0
 *                               },
 *                               {
 *                                   id:"ce3",
 *                                   value:"取消",
 *                                   callback:function(){
 *                                       var self = this;
 *                                       iss.dialog.loading();
 *                                       setTimeout(function(){
 *                                           iss.dialog.loading.close();
 *                                           iss.dialog.success("关闭成功",function(){
 *                                               self && self.close();
 *                                           });
 *                                       },3000)
 *                                       return false;
 *                                   }
 *                               }
 *                           ],
 *                           ok:false
 *                      });
 *                 });
 *              }
 *          });
 *      });

      iss.i
*/

 

;(function(window, document, $, iss, undefined) {
    "use strict";//严格模式



    var //_singleton,//?单例？ 咱项目不用
        _count = 0,//一个标识，为了不重复
        $window = $(window),//存到这一劳永逸
        $document = $(document),//同上
        _expando = 'artDialog' + (+new Date),//记录一个一辈子不重复的标识名，其实直接artDialog也是可以的
        // _isMobile = 'createTouch' in document && !('onmousemove' in document) || /(iPhone|iPad|iPod)/i.test(navigator.userAgent),//判断是否为移动设备
        _isFixed = !true/* && !_isMobile*/;//,//如果不为ie6或者不为移动设备则为true
        // 去操作屏幕焦点
        // _getActive = function() {//焦点操作
        //     try {
        //         // bug: ie8~9, iframe #26
        //         return document.activeElement;
        //     } catch (e) {}
        // },
        // _activeElement = _getActive();//获取焦点

    /**
     * 弹出层构架函数
     */
    var artDialog = function(config, ok, cancel) {

        config = config || {};//如果没有配置参数

        if (typeof config === 'string') {
            config = {
                content: config/*, 
                fixed: !_isMobile*/ //这里注掉是因为下面还是会判断的，这里是如果为字符串就让其fixed，但项目中用不到，so
            }
        }


        var api, defaults = artDialog.defaults;//引用默认参数 和定义是否已经弹出的变量
        // var elem = config.follow = this && this.nodeType === 1 && this || config.follow;//取消吸附


        // 合并默认配置
        for (var i in defaults) {
            if (config[i] === undefined) {//如果配置里没有默认里的就拿默认里的
                config[i] = defaults[i];
            };
        };


        config.id = /*elem && elem[_expando + 'follow'] ||*/ config.id || _expando + _count;//取消吸附 // 分配一个id，如果参数里没有id则使用标识来定一个id
        api = artDialog.list[config.id];//查找缓存里是否有这个弹出层实例，list可视为内部缓存



        if (api) {//如果缓存里有
            // if (elem) {//取消吸附
            //     api.follow(elem)
            // };
            // api.zIndex().focus();
            return api.zIndex();//去操作焦点.focus();//置顶该实例并返回
        };



        // 目前主流移动设备对fixed支持不好，禁用此特性
        if (!_isFixed) {//如果为ie6或者移动端强制让其不用fixed定位
            config.fixed = false;
        };

        // !$.isArray(config.button)
        if (!$.isArray(config.button)) {//如果参数的button不是数组则让其为数组，因为后面要进行push操作追加
            config.button = [];
        };


        // 确定按钮
        if (ok !== undefined) {
            config.ok = ok;
        };

        if (config.ok) {//如果有确认按钮则追加到button数组里
            config.button.push({
                id: 'ok',
                value: config.okValue,
                callback: config.ok,
                focus: true,//确认按钮默认为聚焦状态
                highlight: true//高亮
            });
        };


        // 取消按钮
        if (cancel !== undefined) {
            config.cancel = cancel;
        };

        if (config.cancel) {//如果有取消按钮则追加到button数组里
            config.button.push({
                id: 'cancel',
                value: config.cancelValue,
                callback: config.cancel
            });
        };

        // 更新 zIndex 全局配置
        artDialog.defaults.zIndex = config.zIndex;//把参数里的zindex更新到全局对象里

        _count++;//让标识+1，防止重复





        return artDialog.list[config.id] =
        /* _singleton ?  //单例？干掉
        _singleton._create(config) : */
        new artDialog.fn._create(config);//缓存下对象并返回
    };

    artDialog.version = '5.0.4 for iisoftstone';//版本

    artDialog.fn = artDialog.prototype = {//采用jQuery无需new返回新实例

        //v6事件系统支持

        /**
         * 内部触发事件
         */
        _trigger: function(type){
            var self = this,
                listeners = self._getEventListener(type);

            if("function" === typeof self.config['on'+ type]){
                self.config['on'+ type].call(self);
            }

            for (var i = 0; i < listeners.length; i ++) {
                listeners[i].call(self);
            }
        },

        /**
         * 添加事件
         * @param   {String}    事件类型
         * @param   {Function}  监听函数
         */
        on: function (type, callback) {
            var self = this;

            if(type.indexOf("button:") === 0){
                type = type.slice(7);
                if(!self._callback[type]){
                    self._callback[type] = {};
                }
                self._callback[type].callback = callback;
            } else {
                self._getEventListener(type).push(callback);
            }
            return self;
        },


        /**
         * 删除事件
         * @param   {String}    事件类型
         * @param   {Function}  监听函数
         */
        off: function (type, callback) {
            var self = this,
                listeners,
                i;

            if(type.indexOf("button:") === 0){
                delete self._callback[type.slice(7)];
            } else {
                listeners  = self._getEventListener(type);
                if("function" === typeof callback){
                    for (i = 0; i < listeners.length; i ++) {
                        if (callback === listeners[i]) {
                            listeners.splice(i--, 1);
                        }
                    }
                } else {
                    if("function" === typeof self.config['on'+ type]){
                        delete self.config['on'+ type];
                    }
                    listeners.length = 0;
                }
            }

            
            
            return self;
        },


        // 获取事件缓存
        _getEventListener: function (type) {
            var listener = this._listener;
            if (!listener[type]) {
                listener[type] = [];
            }
            return listener[type];
        },

        _create: function(config) {
            var self = this;
            iss.data("issdialog","open");//全局变量区分普通ifrmae和弹出iframe
            self._listener = {};//v6事件空间
            self._callback = {};//按钮事件空间
            self._dom = {};//jQuery对象
            // self.locked = false;//
            // self.closed = false;//设置关闭标识
            self.config = config;//把参数引用到对象上


           
            self._createHTML(config);//输出html


            //添加对iframe的支持
            if(config.url){

                self._$("wrap").addClass("ui-dialog-iframe");
                
                self._dom.iframe = $('<iframe />')
                    .attr({
                        src: config.url,
                        name: config.id,
                        width: '100%',
                        height: '100%',
                        allowtransparency: 'yes',
                        frameborder: 'no'/*,
                        scrolling: 'no'*/
                    })
                    .on('load', function () {

                        self.DOM[0].style.background="#fff";
                        self.iframeAuto();
                       
                    });

                   

                self.iframe = (self._dom.iframe[0]);
                config.content = self._dom.iframe[0];
                self.on("close", function(){
                    // 重要！需要重置iframe地址，否则下次出现的对话框在IE6、7无法聚焦input
                    // IE删除iframe后，iframe仍然会留在内存中出现上述问题，置换src是最容易解决的方法
                   var doc = this.iframe.contentWindow.document
                       doc.write("");
                       this._$("iframe").attr('src', 'about:blank').remove();
                });

                if(config.url==""||config.url=="about:blank"){
                        self._dom.wrap.find(".ui-dialog-content").css("background","#fff");
                    }

            }

            config.skin && self._$('wrap').addClass(config.skin);//设置皮肤
            self._$('wrap').css('position', config.fixed ? 'fixed' : 'absolute');//定位

            self._$('close').click(function(){
                self._click("close");
            }).attr("title", config.cancelValue);

            self.button.apply(self, config.button);//处理按钮组

            self.title(config.title)//设置标题
                .content(config.content)//设置内容
                .width(config.width)//设置宽高
                .height(config.height)//设置宽高
                .time(config.time)//设置自动关闭
                .gotoFun(config.go)//回调
                .position()//重置位置
                .zIndex()//置顶
                ._addEvent(),//绑定事件
               // .iframe(config.iframe),//绑定iframe

            config.lock && self.lock();//如果有遮罩

            self[config.visible ? 'visible' : 'hidden']();//去焦点.focus();//是否显示

            if(config.follow){
                self.follow(config.follow);
            }

            config.initialize && config.initialize.call(self);//如果有初始化参数则call下
          




            return self;//返回实例
        },
        iframe:"",
        /**
         * 设置iframe自适应
         */
        iframeAuto: function(){
            var self = this,
                config = self.config,
                $iframe = self._dom.iframe,
                test;

            if($iframe){
                try {
                    // 跨域测试
                    test = $iframe[0].contentWindow.frameElement;
                } catch (e) {}

                if (test) {

                    if (!config.width) {
                        self.width($iframe.contents().width());
                    }
                    
                    if (!config.height) {
                        self.height($iframe.contents().height());
                    }
                }
            }
            return self;
        },

        /**
         * 设置内容
         * @param {String} 内容 (可选)
         */
        content: function(message) {
            var self = this;
            self.DOM = self._$('content');
            self.DOM.html(message);
            
            //self._$('content').html(message);//设置内容不解释
            // this._reset();//重置下位置
            //(message.nodeName.toLowerCase()=="iframe")&&self["iframe"]="fdaffasdfasdfasfasdas"
            return this.position();
        },
        

        /**
         * 设置标题
         * @param {(String|Boolean)} 标题内容. 为 false 则隐藏标题栏
         */
        title: function(content) {

            var className = 'ui-dialog-noTitle';//没有标题时的class

            if (content === false) {//如果参数为false才不显示标题
                this._$('title').hide().html('');
                this._$('wrap').addClass(className);
            } else {
                this._$('title').show().html(content);
                this._$('wrap').removeClass(className);
            };

            return this;
        },
        /**
	 *	尺寸
	 *	@param	{Number, String}	宽度
	 *	@param	{Number, String}	高度
	 */
        size: function (width, height) {
            var self = this,
                dom = self.DOM;

            if (width) {
            
                var wh = (width.toString().indexOf("%") > -1) ? width : parseInt(width)+"px";
                dom.css("width", wh);
               
            };

            if (height) {
              
                var hg = (height.toString().indexOf("%") > -1) ? height : parseInt(height) + "px";
                dom.css("height", hg);
            };

            return self;
        },

        /**
         * 内部跟随
         */
        __follow: function(){
            var self = this;
            var $elem = self._dom.follow;
            var popup = self._$("wrap");


            if (this.__followSkin) {
                popup.removeClass(this.__followSkin);
            }
            


            // 隐藏元素不可用
            if ($elem) {

                var o = $elem.offset();
                if (o.left * o.top < 0) {
                    return self.__center();
                }
            }
            
            var that = this;
            var fixed = this.config.fixed;

            var winWidth = $window.width();
            var winHeight = $window.height();
            var docLeft =  $document.scrollLeft();
            var docTop = $document.scrollTop();


            var popupWidth = popup.width();
            var popupHeight = popup.height();
            var width = $elem ? $elem.outerWidth() : 0;
            var height = $elem ? $elem.outerHeight() : 0;
            var offset = this.__offset();
            var x = offset.left;
            var y = offset.top;
            var left =  fixed ? x - docLeft : x;
            var top = fixed ? y - docTop : y;


            var minLeft = fixed ? 0 : docLeft;
            var minTop = fixed ? 0 : docTop;
            var maxLeft = minLeft + winWidth - popupWidth;
            var maxTop = minTop + winHeight - popupHeight;


            var css = {};
            var align = self.config.align.split(' ');
            var className = 'ui-dialog-';
            var reverse = {top: 'bottom', bottom: 'top', left: 'right', right: 'left'};
            var name = {top: 'top', bottom: 'top', left: 'left', right: 'left'};


            var temp = [{
                top: top - popupHeight,
                bottom: top + height,
                left: left - popupWidth,
                right: left + width
            }, {
                top: top,
                bottom: top - popupHeight + height,
                left: left,
                right: left - popupWidth + width
            }];


            var center = {
                left: left + width / 2 - popupWidth / 2,
                top: top + height / 2 - popupHeight / 2
            };

            
            var range = {
                left: [minLeft, maxLeft],
                top: [minTop, maxTop]
            };


            // 超出可视区域重新适应位置
            $.each(align, function (i, val) {

                // 超出右或下边界：使用左或者上边对齐
                if (temp[i][val] > range[name[val]][1]) {
                    val = align[i] = reverse[val];
                }

                // 超出左或右边界：使用右或者下边对齐
                if (temp[i][val] < range[name[val]][0]) {
                    align[i] = reverse[val];
                }

            });


            // 一个参数的情况
            if (!align[1]) {
                name[align[1]] = name[align[0]] === 'left' ? 'top' : 'left';
                temp[1][align[1]] = center[name[align[1]]];
            }

            className += align.join('-');
            
            that.__followSkin = className;


            // if ($elem) {
                popup.addClass(className);
            // }

            
            css[name[align[0]]] = parseInt(temp[0][align[0]]);
            css[name[align[1]]] = parseInt(temp[1][align[1]]);
            popup.css(css);
        },


        __offset: function () {


            var self = this;
            var $elem = self._dom.follow;
            var offset = $elem.offset();


            var ownerDocument = $elem[0].ownerDocument;
            var defaultView = ownerDocument.defaultView || ownerDocument.parentWindow;
            
            if (defaultView == window) {// IE <= 8 只能使用两个等于号
                return offset;
            }

            // {Element Ifarme}
            var frameElement = defaultView.frameElement;
            var $ownerDocument = $(ownerDocument);
            var docLeft =  $ownerDocument.scrollLeft();
            var docTop = $ownerDocument.scrollTop();
            var frameOffset = $(frameElement).offset();
            var frameLeft = frameOffset.left;
            var frameTop = frameOffset.top;
            
            return {
                left: offset.left + frameLeft - docLeft,
                top: offset.top + frameTop - docTop
            };
        },

        follow: function(elem){
            var self = this;

            self._$("wrap").addClass("ui-dialog-follow");

            self._dom.follow = (elem && $(elem)) || self._dom.follow;

            

            return self.position();
        },


        /** @inner 位置居中 */
        position: function() {

            var self = this;

            if(self._dom.follow){
                self.__follow();
            } else {
                self.__center();
            }

            return self;
        },

        /**
         * 内部居中
         */
        __center: function(){
            var wrap = this._$('wrap')[0],
                fixed = this.config.fixed,//判断是否为fixed定位
                dl = fixed ? 0 : $document.scrollLeft(),//如果不是则找到滚动条
                dt = fixed ? 0 : $document.scrollTop(),//同上
                ww = $window.width(),//窗口的宽
                wh = $window.height(),//窗口的高
                ow = wrap.offsetWidth,//当前弹层的宽
                oh = wrap.offsetHeight,//同上
                left = (ww - ow) / 2 + dl,
                top = (wh - oh)/2 + dt;//(wh - oh) * 382 / 1000 + dt;//项目不让使用黄金比例
            
            wrap.style.left = Math.max(parseInt(left), dl) + 'px';
            wrap.style.top = Math.max(parseInt(top), dt) + 'px';
        },



        width: function(value){
            var self = this;
            //如果是获取宽
            if(value === undefined){
                return self._$("wrap").width();
            }
            self._$("content").width(value);
            return self.position();
        },

        height: function(value){
            var self = this;
            //如果是获取高
            if(value === undefined){
                return self._$("wrap").height();
            }
            self._$("content").height(value);
            return self.position();
        },

        button: function() {


            var self = this,
                buttons = self._$('buttons')[0],//dom下
                callback = self._callback,//0000事件空间
                ags = [].slice.call(arguments);

            var i = 0,
                val, value, id, isNewButton, button, className;

            for (; i < ags.length; i++) {

                val = ags[i];//当前的按钮对象

                id = val.id || value;//找到id


                value = val.value || (callback[id] && callback[id].value) || "确定";//如果没有设置value


                isNewButton = !callback[id];//是否已经存在
                button = isNewButton ? document.createElement('a') : callback[id].elem;//如果已存在则拿dom，否则创建dom
                button.href = 'javascript:;';//你懂的
                className = 'ui-dialog-button';//按钮class

                if (isNewButton) {//如果为新按钮
                    callback[id] = {};
                }

                //写入到按钮和空间上
                button.innerHTML = callback[id].value = value;

                //如果有设置宽
                if (val.width) {
                    button.style.width = "number" === typeof (val.width) ? (val.width+"px") : val.width;
                }

                //如果禁用
                if ( !! val.disabled) { 
                    className += ' ui-dialog-button-disabled';//禁用的class
                    if (!val.callback) {//如果已禁用且没有回调则设置return false
                        val.callback = function() {
                            return false;
                        }
                    }
                }

                //如果有回调
                if (val.callback) {
                    callback[id].callback = val.callback;
                }

                if (val.focus) {//如果为聚焦
                    self._focus && self._focus.removeClass('ui-dialog-button-focus');//移除老聚焦的按钮
                    className += ' ui-dialog-button-focus';//给当前添加聚焦
                    self._focus = $(button);
                }

                if(val.highlight){//如果高亮
                    className += ' ui-dialog-button-on';
                }

                if(val.className){//如果配置的按钮有class则追加下
                    className += ' '+ val.className;
                };



                button.className = className;


                button.setAttribute(_expando + 'callback', id);//为了委托事件用

                if (isNewButton) {//如果为新按钮则追加到dom
                    callback[id].elem = button;
                    buttons.appendChild(button);
                }
            }

            buttons.style.display = ags.length ? '' : 'none';

            self._focus && self._focus.focus();//只操作按钮的焦点，而不管窗口的焦点，否则ie6有严重bug

            return self;
        },


        /** 显示对话框 */
        visible: function() {
            //this.dom.wrap.show();
            var self = this;
            self._$('wrap').show();
            self._$('wrap').addClass('ui-dialog-visible');

            if (self.locked) {
                self._dom.mask.show();
            }

            self._trigger("visible");
            self._goto();
            return self;
        },
        _goto:function(){},
        //回调
        gotoFun:function(fun){
            var self = this;
           fun&&(self._goto=fun);
           return self;
        },
        /** 隐藏对话框 */
        hidden: function() {
            //this.dom.wrap.hide();
            var self = this;
            self._$('wrap').hide();
            self._$('wrap').removeClass('ui-dialog-visible');

            if (self.locked) {
                self._dom.mask.hide();
            };


            self._trigger("hidden");

            return self;
        },


        /** 关闭对话框 */
        close: function() {
            var self = this,
                beforeunload;

            if (self.closed) {
                return self;
            }

            beforeunload = self.config.beforeunload;

            if (beforeunload && beforeunload.call(self) === false) {
                return self;
            }


            if (artDialog.focus === self) {
                artDialog.focus = null;
            }


            // if (self._follow) {//去掉吸附
            //     self._follow.removeAttribute(_expando + 'follow');
            // }


            self._trigger("close");


            self.time().unlock();//._removeEvent();//jQuery会自己卸载
          
            delete artDialog.list[self.config.id];
            delete self.iframe;
            //self._$('wrap').remove();
            
             var wap = document.getElementById(self.config.id);
                 wap.parentNode.removeChild(wap);

            //采用v6的删除方法，减少资源
            for(var i in self){
                delete self[i];
            }
            
            self.closed = true;

            // if (_singleton) {

            

            // 使用单例模式
            // } else {

            //     _singleton = self;

            //     dom.title.html('');
            //     dom.content.html('');
            //     dom.buttons.html('');

            //     $wrap[0].className = $wrap[0].style.cssText = '';
            //     dom.outer[0].className = 'ui-dialog-outer';

            //     $wrap.css({
            //         left: 0,
            //         top: 0,
            //         position: _isFixed ? 'fixed' : 'absolute'
            //     });

            //     for (var i in this) {
            //         if (this.hasOwnProperty(i) && i !== 'dom') {
            //             delete this[i];
            //         };
            //     };

            //     this.hidden();

            // };

            // 恢复焦点，照顾键盘操作的用户
            // 去焦点
            // if (_activeElement) {
            //     try{
            //         setTimeout(function(){
            //             _activeElement.focus();
            //         },100);
            //     } catch(e){}
            // }

            
            return self;
        },


        /**
         * 定时关闭
         * @param {Number} 单位毫秒, 无参数则停止计时器
         */
        time: function(time) {

            var self = this,
                timer = self._timer;

            timer && clearTimeout(timer);

            if (time) {
                self._timer = setTimeout(function() {
                    self._click('close');
                }, time);
            };


            return self;
        },

        /** @inner 设置焦点 */
        // 去焦点
        // focus: function() {

        //     var that = this,
        //         isFocus = function() {
        //             var activeElement = _getActive();
        //             return activeElement && that._$('wrap')[0].contains(activeElement);
        //         };

        //     if (!isFocus()) {
        //         _activeElement = _getActive();
        //     }

        //     setTimeout(function() {
        //         if (!isFocus()) {
        //             try {
        //                 var elem = that._focus || that._$('close') || taht._$('wrap');
        //                 elem[0].focus();
        //                 // IE对不可见元素设置焦点会报错
        //             } catch (e) {};
        //         }
        //     }, 16);

        //     return this;
        // },


        /** 置顶对话框 */
        zIndex: function() {

            var /*dom = this.dom,*/
                self = this,
                top = artDialog.focus,
                index = artDialog.defaults.zIndex++;

            // 设置叠加高度
            self._$('wrap').css('zIndex', index);
            self._dom.mask && self._dom.mask.css('zIndex', index - 1);

            // 设置最高层的样式
            top && top._$('wrap').removeClass('ui-dialog-focus');
            artDialog.focus = self;
            self._$('wrap').addClass('ui-dialog-focus');

            return self;
        },


        /** 设置屏锁 */
        lock: function() {

            var self = this,
                config = self.config,
                div,
                index,
                css;

            if (self.locked) {
                return self;
            }

            div = document.createElement("div");
            css = {
                position: 'fixed',
                left: 0,
                top: 0,
                width: '100%',
                height: '100%',
                overflow: 'hidden'
            }

            

            div.className = 'ui-dialog-mask';

            config.backgroundColor && (css['backgroundColor'] = config.backgroundColor);
            config.backgroundOpacity && (css['opacity'] = config.backgroundOpacity);

            if (!_isFixed) {
                css.position = 'fixed';
                css.width = "100%"; //$window.width();
                css.height = $document.height();
            };



            document.body.appendChild(div);

            self._dom.mask = $(div).css(css).on("dblclick", function () {
                //遮罩双击关闭弹出屏蔽
                return
                self._click("close");
            })

            self.locked = true;

            self.zIndex()._$('wrap').addClass('ui-dialog-lock');
            return self;
        },


        /** 解开屏锁 */
        unlock: function() {
            var self = this;
            if (!self.locked) {
                return self;
            }
            self._$('wrap').removeClass('ui-dialoge-lock');
            self._$("mask").remove();
            self.locked = false;

            return self;
        },


        // 获取元素
        _createHTML: function(data) {

            var $wrap = $("<div />")
                .css({
                    position: 'absolute',
                    left: '-9999em',
                    top: 0
                })
                .attr("id",this.config.id);
                // .attr({
                //     'role': this.config.lock ? 'alertdialog' : 'dialog',
                //     'tabindex': -1
                // });

            $wrap[0].innerHTML = artDialog._templates;

            $(document.body).append($wrap);//插入到前面ie67有问题
            // document.body.insertBefore(wrap, document.body.firstChild);
            this._dom.wrap = $wrap;
        },

        //获取jQuery对象
        _$: function(i){
            var dom = this._dom;
            return dom[i] || (dom[i] = dom.wrap.find('[data-dom=' + i + ']'));
        },


        // 按钮回调函数触发
        _click: function(id) {
            var self = this,
                fn = self._callback[id] && self._callback[id].callback;

            return typeof fn !== 'function' || fn.call(self) !== false ?
                self.close() : self;
        },


        // 重置位置
        // _reset: function() {
        //     var elem = this.config.follow || this._follow;//去掉吸附
        //     elem ? this.follow(elem) : 
        //     return this.position();
        // },
        _wap:"",

        // 事件代理
        _addEvent: function() {

            var self = this;/*,
                dom = this.dom;*/

            // 优化事件代理
            self._$("buttons").on("click", "a", function(){
                var callbackID,
                    $this = $(this);

                if(!$this.hasClass('ui-dialog-button-disabled')){
                    callbackID = $this.attr(_expando +'callback');
                    callbackID && self._click(callbackID);
                }
            });

            self._$("wrap").on('mousedown', function() {
                self.zIndex();
            });

            // 监听点击
            // that._$('wrap')
            //     .bind('click', function(event) {

            //         var target = event.target,
            //             callbackID;

            //         // IE BUG
            //         if (target.disabled) {
            //             return false;
            //         };

            //         if (target === that._$('close')[0]) {
            //             that._click('cancel');
            //             return false;
            //         } else {
            //             callbackID = target[_expando + 'callback'];
            //             callbackID && that._click(callbackID);
            //         };

            //     })
            //     .bind('mousedown', function() {
            //         that.zIndex();
            //     });

        }/*,


        // 卸载事件代理 不用卸载, 因为在remove的时候会自动卸载
        _removeEvent: function() {
            this._$('wrap').unbind();
        }*/

    }

    artDialog.fn._create.prototype = artDialog.fn;



    // 快捷方式绑定触发元素
    // $.fn.dialog = $.fn.artDialog = function() {
    //     var config = arguments;
    //     this[this.live ? 'live' : 'bind']('click', function() {
    //         artDialog.apply(this, config);
    //         return false;
    //     });
    //     return this;
    // };



    /** 最顶层的对话框API */
    artDialog.focus = null;



    /**
     * 根据 ID 获取某对话框 API
     * @param {String} 对话框 ID
     * @return {Object} 对话框 API (实例)
     */
    artDialog.get = function(id) {
        var iframe,
            list = artDialog.list,
            key;

        // 从 iframe 传入 window 对象
        if (id && id.frameElement) {
            iframe = id.frameElement;
            for (key in list) {
                if(list[key]._dom.iframe && list[key]._dom.iframe[0] === iframe){
                    return list[key];
                }
            }
        } else if(id) {
            return list[id];
        } else {
            return list;
        }
    }

    artDialog.list = {};



    //// 全局快捷键
    //$(document).bind('keydown', function (event) {
    //    var target = event.target,
    //        nodeName = target.nodeName,
    //        rinput = /^input|textarea$/i,
    //        api = artDialog.focus,
    //        keyCode = event.keyCode;

    //    if (!api || rinput.test(nodeName) && target.type !== 'button') {
    //        return;
    //    };
    //    
    //    // ESC
    //    keyCode === 27 && api._click('cancel');
    //});


    // 锁屏限制tab
    // function focusin(event) {
    //     var api = artDialog.focus;
    //     if (api && api.locked && !api.dom.wrap[0].contains(event.target)) {
    //         event.stopPropagation();
    //         api.dom.outer[0].focus();
    //     }
    // }

    // if ($.fn.live) {
    //     $('body').live('focus', focusin);
    // } else if (document.addEventListener) {
    //     document.addEventListener('focus', focusin, true);
    // } else {
    //     $(document).bind('focusin', focusin);
    // }



    // 浏览器窗口改变后重置对话框位置
    $(window).bind('resize', function() {
        var id;
        for (id in artDialog.list) {
            artDialog.list[id].position();
           
        }
    });



// 可用 dialog._$(name) 获取 data-dom 的jQuery对象
// 已知dom:  inner,title,close,content,footer,buttons,header
artDialog._templates =
    '<div class="ui-dialog-outer">' 
        + '<i class="ui-dialog-arrow-a"></i>'
        + '<i class="ui-dialog-arrow-b"></i>'
        + '<table class="ui-dialog-border">' 
            + '<tbody>' 
                + '<tr>' 
                    + '<td>' 
                        + '<div class="ui-dialog-inner" data-dom="inner">'
                            + '<div class="ui-dialog-header" data-dom="header">'
                                + '<div class="ui-dialog-title-outer">'
                                    + '<div data-dom="title" class="ui-dialog-title"></div>'
                                    + '<a class="ui-dialog-close" href="javascript:;" data-dom="close"></a>'
                                + '</div>'
                            + '</div>'
                            + '<div data-dom="content" class="ui-dialog-content"></div>'
                            + '<div class="ui-dialog-footer" data-dom="footer">'
                                + '<div class="ui-dialog-buttons" data-dom="buttons"></div>'
                            + '</div>'
                        + '</div>' 
                     + '</td>' 
                + '</tr>' 
            + '</tbody>' 
        + '</table>' 
    + '</div>';



    /**
     * 默认配置
     */
    artDialog.defaults = {

        // 消息内容
        content: '<div class="ui-dialog-loading" title="加载中">加载中</div>',

        // 标题
        title: '\u63D0\u793A',

        // 自定义按钮
        button: null,

        // 确定按钮回调函数
        ok: null,

        // 取消按钮回调函数
        cancel: null,

        // 对话框初始化后执行的函数
        initialize: null,

        // 对话框关闭前执行的函数
        beforeunload: null,

        // 确定按钮文本
        okValue: '\u786E\u5B9A',

        // 取消按钮文本
        cancelValue: '\u53D6\u6D88',

        // 内容宽度
        width: '',

        // 内容高度
        height: '',

        // 皮肤名(多皮肤共存预留接口)
        skin: "",

        // 自动关闭时间(毫秒)
        time: 0,

        // 初始化后是否显示对话框
        visible: true,
        go:function(){},//回调
        // 让对话框跟随某元素
        // follow: null, //去掉吸附

        // 是否锁屏
        lock: false,

        // 是否固定定位
        fixed: false,

        // 对话框叠加高度值(重要：此值不能超过浏览器最大限制)
        zIndex: 3e5,

        backgroundColor:"",

        backgroundOpacity:"",
        align:'bottom'

    };



    /**
     * 通用弹出层提示
     * @memberOf iss.dialog
     * @function
     * @param   {(object | array | string)}         options     dialog参数对象或数组或者字符串
     * @param   {(function| empty)}                 fn          确定按钮回调或者空
     * @example
     *     1: iss.dialog.alert("操作成功");
     *     2: iss.dialog.alert("请求失败",function(){});
     *     3: iss.dialog.alert(["您不是VIP用户，无权操作","现在开通还有好礼相送哦"],function(){});
     *     4: iss.dialog.alert({
     *            content:["确定要删除该日志吗？","删除后该日志下的评论也将删除，且不能恢复"],
     *            ok:function(){
     *            },
     *            okValue:"删除",
     *            cancel:1,
     *            title:"警告"
     *        });
     */
    artDialog.alert = function (options, fn, cancel) {
       
       
        if ("string" === typeof options || $.isArray(options)) {
            options = {
                content: options,
                ok:fn,
                cancel:cancel
            };
        };
        options = (options[0] instanceof Object) ? options[0] : options;
       

        // if (!options.title) { //如果没有标题则加上关闭按钮
        //     options.title = false;
        // };
        if ($.isArray(options.content)) { //如果内容为数组
            options.content = ['<h3>' + options.content[0] + '</h3>','<p>' + options.content[1] + '</p>'].join("");
        } else {
            options.content = '<div>'+ (options.content || "请稍等") +'</div>';
        };
        // options.skin = "msc-dialog-alert";
        // options.width = options.width || 380;
        // options.fixed = options.fixed || 1;
        // options.lock = 1;
        // options.ok = options.ok === undefined ? 1 : options.ok;
        return artDialog($.extend({
            skin : 'msc-dialog-alert',
            width : 380,
            fixed : 1,
            lock : 1,
            ok : 1,
            title: !1
        },options));
    };

    artDialog.confirm = function (txt,okfn,cancelfn) {
            
            options = {
                content:txt? txt:"内容为空！",
                ok: okfn? okfn:true,
                cancel:cancelfn? cancelfn:true
            };
      
        options = options || {};
        option.content = "<div>" + option.content + "</div>";
        return artDialog($.extend({
            skin: 'msc-dialog-alert',
            width: 380,
            fixed: 1,
            lock: 1,
            ok: 1,
            title: !1
        }, options));
    }


    /**
     * 成功、错误、警告     
     * @memberOf iss.dialog
     * @function
     * @param   {(object | string)}    options    dialog参数对象或者字符串
     * @param   {number}              num        自动关闭的倒计时， ms
     * @return  {object}                         dialog对象
     * @example
     *     1: iss.dialog.success("删除成功");
     *     2: iss.dialog.error("分类不存在",4000);
     *     3: iss.dialog.warning("您不是管理员");
     */
    $.each(['success', 'error', 'warning'], function(i, that) {
        artDialog[that] = function(options, num) {
            if ("string" === typeof options) {
                options = {
                    content: options,
                    time: "function" === typeof num ? 0 : num,
                    beforeunload: "function" === typeof num ? num : 0
                };
            };
            options = options || {};
            options.content = '<p>' + options.content + '</p><i class="msc-dialog-tips-icon msc-dialog-tips-'+ that +'-icon"></i>';
            options.skin = "msc-dialog-tips";
            options.time = options.time || 2*1e3;
            options.fixed = 1;
            options.title = options.cancel = false;
            return artDialog(options);
        };
    });
    artDialog["confirm"] = function (arg,okfn,canfn) {
       
       
        if (typeof arg == "string") {
            return iss.dialog.alert({
                title: "提示消息",
                content: arg ? arg : "提示消息",
                ok: okfn ? okfn : true,
                cancel:canfn? canfn:true
            })
        } else if (arg instanceof Object) {
           
            artDialog.confirm(arg[0], arg[1], arg[2])

        }

    }

    /**
     * loading等待层，不可关闭，只有 iss.dialog.loading.close() 才能关闭这个层
     * @memberOf iss.dialog
     * @function
     * @example
     *     iss.dialog.loading();//会遮罩起屏幕，且不能关闭
     */
    artDialog.loading = function() {
        $("html").css("overflow-y", 'hidden');
        return artDialog({
            title:false,
            cancel:false,
            lock:1,
            backgroundColor:"#000",
            backgroundOpacity:0.2,
            beforeunload:function(){
                return false;
            },
            skin: "msc-dialog-loading",
            id: "msc-loading",
            fixed: 1
        });
    }

    /**
     * 关闭等待层，只关闭，你懂的 *_*
     * @memberOf iss.dialog
     * @name iss.dialog.loading.close
     * @function
     * @example
     *     iss.dialog.loading.clsoe();//删除等待层
     */
    artDialog.loading.close = function(){
        var api = artDialog.get("msc-loading");
        $("html").css("overflow-y", 'visible');
        if(api){
            api.config.beforeunload = null;
            api.close();
        }
        api = null;
    } 
    
    //关闭层
    artDialog.close = function(){
        var th = this.list;
        $.each(th,function(ind,ele){
            ele.close();
        })
    }

    //把第一次给命名空间
    // msc.register("iss");
    //iss["set_issdialog"] = artDialog;
    iss.dialog = artDialog;
    // 页面首次执行
    (function(){
        $.each(iss._fn.issdialog,function(i,e){
           
            if (e[1][1]) {
                artDialog[e[0]](e[1][0], e[1][1], e[1][2] || "");
            } else {
                artDialog[e[0]](e[1][0]);
            }
           // artDialog[e[0]](e[1][0]);
        })

    })();

}(window, document, jQuery, iss));







