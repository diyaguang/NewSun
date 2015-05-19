;
(function($, window, undefined) {

	var formTable = function(config) {

		var time = new Date().getTime();

		formTable.config.id = "formTable" + time;
		return formTable.init[formTable.config.id] = new formTable.fn._create(config);
	}
	formTable.fn = formTable.prototype = {

		_create: function(arg) {
          
		    var self = this;
			//	config = $.extend(self.config, arg); //合并自定义属性和默认属性
			arg && arg.url ? self.getURL(arg.url) : (arg instanceof Object) && self._table(arg);
			
			return
		},
		getURL: function(url) {

			var self = this;

			url || (function() {
				alert("未定义获取json的URL");
				return false
			})();
			$.get(url, function(data) {

				self._table(data);

			}, "JSON")
				.fail(function(e) {

					alert("大哥你确认:" + url + "是对的。")
				})
		},
		_table: function(arg) {
			//console.log(data);
		    var self = this,
                app = arg["append"],
		        data = arg.data;
               
			if (data.Subject == null) {
				alert("数据错误");
				return
			};

			self._init.max = data.MaxLevel;
			self._init.option = data.Option;
			//console.log(message);
			self._init.step = data.CurrentStep;
			self._init.rowcount = data.RowCount;

		
		    ; (function () {
		        for (var i = 0; i <= self._init.option.length; i++) {
		            self.str += (i == 0) ? "<div class='iss-formtable-head'><span class='iss-left'>指标名称" + /*self._init.option[i]["ChName"] +*/ " </span>" : "<span class='iss-right step" + (self._init.option.length - i) + "'>" + self._init.option[self._init.option.length - i]["ChName"] + "</span>";
		            (self._init.option.length == i) && (self.str += "</div>");
		        };
		        self.getData(data.Subject);
		       
		        if (app == null) {
		            var tt = $("<div class='iss-formTable'></div>");
		            $("body").append(tt);
		            tt.append(self.str);
		        } else {
		        }
		        $(app).append(self.str);

			})()


		},
		getData: function(da) {
			var self = this;

			//self.str += "<table class='parent'>";
			for (var i in da) {
				var data = da[i],
					num = data["Children"],
					leve = data["Level"],
					db = data["Data"],
					id = data["ID"] ? data["ID"] : "",
					cl = num ? self._init.max + self._init.option.length - 1 : 1,
					left = num.length ? "" : "iss-left",
					last = num.length ? "":"iss-lastbox"
				ss = num ? " iss-formtable-name" : " iss-formtable-box";
				self.str += "<div class='"+last+" iss-formtable-parent'><p class='" + left + " iss-formtable-name-" + leve + ss + "'>" + data["Name"] + "</p>";


				if (num.length <= 0) {

					var
						opt = self._init.option,
						len = opt.length,
						f=0,
						j = 0;

					self.str += "<div class='iss-right'>";

					for (; j < len; j++) {

						var edt = "";
						   
						if (opt[j]["Type"] == "data") {
 							//	console.log(f+":"+self._init.step);
								if (f == self._init.step) {
									si=j;

									edt =  "<input type='text' class='iss-formtable-input' name='"+id+"' iss-id='"+id+"' value='"+(db[f]? db[f]:'')+"' />";
								    
								} else {

									edt = (db[f])? db[f]:"--";

								}
								f++;

							//}
							

						} else if (opt[j]["Type"] == "property") {
                            
						    
						    edt = data[opt[j]["EnName"]] ? (data[opt[j]["EnName"]]) : "--";
						       
						        
							//edt= (data[opt[j]["Type"]])? (data[opt[j]["Type"]]):"--";
						}


						self.str += "<span class='step step"+j+"' iss-num=" + j + ">" + edt + "</span>";
					}
					self.str += "</div>";
				} else {

					self.str += "<div class='iss-formtable-child'>";
					self.getData(data["Children"]);
					self.str += "</div>";
				};

				self.str += "</div>";

			}
			//self.str += "</table>";
			return self.str;



		},
		str: "",
		_init: {
			max: 0, //最大深度
			option: 0, //右侧单元格数量
			rowcount: 0, //最大行数
			table: "", //保存创建单元格string
			data: ""//对应data数据,
           
		}



	}
	formTable.init = {};
	formTable.config = {
	    url: "",
	    append: "body"
	};

	formTable.fn._create.prototype = formTable.fn;

	iss.formTable = formTable;

	$.each(iss._fn.issformTable, function(i, e) {

		iss.formTable(e);

	});

})(jQuery, window)