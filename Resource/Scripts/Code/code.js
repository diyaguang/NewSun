(function (global) {
    "use strict";
    if (global.jsCode) {
        return
    }

    var jsCode = global.jsCode = {}, configData = {}, plugins = {}, styles = {};


    jsCode.config = function (config) {
        if (config) configData = $.extend({
            IsProductionEnvironment: true,
            BasePath: "/scripts/plugins/",
            Plugins: {}

        }, config);

        return configData;
    }

    jsCode.require = function (name) {
        /// <signature>
        ///   <summary>导入模块或是引入js文件.</summary>
        ///   <param name="name" type="String">模块名称或js资源路径.</param>
        /// </signature>
        if (plugins[name]) {
            return;
        }

        plugins[name] = name;
        var script = name, refs;
        if (configData.Plugins && (script = configData.Plugins[name])) {

            if (isObject(script) && script["src"]) {

                if (refs = script["reference"]) {
                    if (isArray(refs))
                        for (var i in refs) {
                            require(refs[i]);
                        }
                    else
                        require(refs);
                }
                if (refs = script["style"]) {


                    if (isObject(refs) && refs["src"]) {
                        refs = configData.IsProductionEnvironment && refs["min"] || refs["src"]
                    }

                    if (isArray(refs)) {
                        for (var i in refs) {
                            addLink(Path.Combine(configData.BasePath, name, refs[i]));
                        }
                    }
                    else {

                        addLink(Path.Combine(configData.BasePath, name, refs));
                    }
                }

                if (configData.IsProductionEnvironment) {
                    script = script["min"] || script["src"];
                } else {
                    script = script["src"];
                }
            }

            if (isString(script)) {
                script = Path.Combine(configData.BasePath, name, script);
                addScript(script);
            } else if (isArray(script)) {
                batchAddScript(Path.Combine(configData.BasePath, name), script)
            }
        } else {
            addScript(name);
        }
    }

    jsCode.addLink = function (url) {
        if (!styles[url]) {
            addLink(url);
            styles[url] = "1";
        }
    }


    var batchAddScript = function (path, files) {
        for (var i in files)
            addScript(Path.Combine(path, files[i]));

    }

    var addScript = function (url) {
        if (!configData.IsProductionEnvironment) {
            url = "{0}{1}=_{2}".format(url, url.indexOf("?") > 0 ? "&" : "?", new Date().getTime())
        }
        document.write("<script src='{0}'><\/script>".format(url));
    }

    var addLink = function (url) {
        if (!configData.IsProductionEnvironment) {
            url = "{0}{1}=_{2}".format(url, url.indexOf("?") > 0 ? "&" : "?", new Date().getTime())
        }

        $("head").append('<link href="{0}" rel="stylesheet" />'.format(url));
    }

    var init = function () {
        window.onerror = function (e) {
            Message.Error(e);
            return true;
        }

        if (!window.JSON) {
            require("json");
        }
    }

    init();

})(this);


var Path = {
    Combine: function () {
        var path = "";
        for (var i in arguments) {
            path += arguments[i] + "/";
        }
        return path.slice(0, -1).replace(/\/+/g, "/");
    }
}

var Message = {
    Error: function (str) {
       // console.error(str);
    }
}

function isType(type) {
    return function (obj) {
        return {}.toString.call(obj) == "[object " + type + "]"
    }
}

var isObject = isType("Object"),
    isString = isType("String"),
    isArray = Array.isArray || isType("Array"),
    isFunction = isType("Function"),
    require = jsCode.require;

String.prototype.format = function () {
    var str = this,
        args = arguments;
    return str.replace(/({\d+})/g, function (i) {
        /(\d+)/.test(i);
        return args[RegExp.$1];
    });
}

String.prototype.decode = function () {
    return decodeURIComponent(this);
}

String.prototype.encode = function () {
    return encodeURIComponent(this);
}


