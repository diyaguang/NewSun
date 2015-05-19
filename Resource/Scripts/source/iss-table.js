/**
 * [Ëø¶¨±íÍ·±íÁÐ iss.table()]
 * @param  {[type]} $      [description]
 * @param  {[type]} window [description]
 * @param  {[type]} iss    [description]
 * @return {[type]}        [description]
 */
;
(function($, window, iss) {

	//¡°iss.set_isstable¡±±ê×¼Ãû³Æ"iss.set_iss"+¿Ø¼þÃû³ÆÒýµ¼³ÌÐòiis.jsÖÐ¶ÔÓ¦¡£
	var
		_cout = 0,
		setTable = iss.set_isstable = function(arg) {

			//return new setTable.fn(arg);
			return setTable.list[_cout++] = new setTable.fn._crate(arg);
		}

	setTable.fn = setTable.prototype = {

		constructor: setTable.fn,
		_crate: function(arg) {
			var self = this,
				ar = ((arg instanceof Array) && arg) || ((typeof arg === "string") && arg.split(","));
			/*拆分表格*/
			$.each(ar, function(ind, ele) {
				var ele = $(ele),
					_txt = ele.html(),
					_body = _txt.match(/<tbody[\s\S]*?>[\S\s]*?<\/tbody>/ig).toString(),
					_left = '<table cellpadding="0" cellspacing="0" class="table_left">' + _body.match(/<tr.*?>[\s]*?<th[\s\S]*?(?=<td.*?>)/ig).join("</tr>") + "</tr></table>",
					_top = '<table cellpadding="0" cellspacing="0" class="table_top" width="100%">' + _txt.match(/<thead\>[\s\S]*?<\/thead>/ig).toString() + "</table>",
					_right = '<table cellpadding="0" cellspacing="0" class="table_right">' + _body.replace(/<th.*?>[\s\S]*?<\/th>/igm, "") + '</table>';
				_left_width = _top.match(/(?:<th)[\s\S]*?(?=>)/ig)
					.toString()
					.replace(/<thead,|<th/ig, "")
					.split(","),
				_right_wdith =_top.match(/<[\s]*tr[\s\S]*?>[\s\S]*?<[\s]*th[\s\S]*?>[\s\S]*?<[\s]*\/tr[\s]*>/ig).toString()
								  .match(/<\s*?th[\s\S]*?>[\S\s]*?<\s*?\/th\s*?>/ig),
				_temp = self._temp.replace(/\{%head%\}/ig, _top)
					.replace(/\{%left%\}/ig, _left)
					.replace(/\{%right%\}/ig, _right),
				$_temp = $(_temp),
				// 添加拆分好的模板到原位置删除源文件防止后期获取时候重复,并放入_source变量中保存,这样new的好处就是会保存私有的_source，保证不重复。
				self._soruce = ele.after(_temp).remove(),
				// 设置左侧宽度锁定$_left_th = $(".table_left tr:first th");
				$_left_th = $(".table_left tr:first th");
				$_left_th.each(function(i, e) {
					var _e = $(e),
						_w = (/width[\s]*?=[\s]*?['"]*(\d+)['"]*/ig).exec(_left_width[i])[1];
					_e.attr("width", _w);
					_e.closest("table").css("width", (_w = +_w) + "px");
					//清除右侧需要移动至左侧的内容。
					_right_wdith.shift();
				});
				$(".table_right tbody").prepend(_right_wdith).css("width");
				//var _width_ = $("")
              
				

			});

		},
		_temp: '<div class="isstable">' +
			'<div class="isstable_head">{%head%}</div>' +
			'<div class="isstable_left">{%left%}</div>' +
			'<div class="isstable_right">{%right%}</div>' +
			'</div>',
		_soruce: {}

	}

	setTable.fn._crate.prototype = setTable.fn;

	setTable.list = [];
	setTable(iss._fn.isstable);

})(jQuery, window, window.iss)