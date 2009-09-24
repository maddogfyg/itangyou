/**
 *对话框类
 *用于创建多个窗口，方便切换操作。
 *使用：PW.Dialog(JSONArgu);
 *JSONArgu 为一个object类型数据。如： {id:'',url:'',name:''}
 *@param string id 窗口id。
 *@param string url 窗口所对应的url地址
 *@param string name 窗口的标题.
 */
~
function()
{
	/**
	 *获取对象的相对于body的绝对坐标
	 *@param nodeElement d 对象
	 *@return Array:[x,y]
	 */
    var _getPos = function(d)
    {
        var e = [0, 0];
        var el = d;
        while (el)
        {
            if (el == document.body) break;

            e[0] = e[0] + el.offsetLeft;
            e[1] = e[1] + el.offsetTop;
            el = el.offsetParent;
        }
        return e;
    };	  

    PW.Dialog = function(items)
    {
		window.MOUSE_OVERED=false;
		if(!$("iframe_"+items.id))
		{
			var ifr=document.createElement("iframe");
			ifr.scrolling="auto";
			ifr.width="100%";
			ifr.height=$('desktopContainer').offsetHeight+"px";
			ifr.frameBorder="no";
			ifr.style.border="0"; 
			ifr.src=items.url;
			ifr.id="iframe_"+items.id;
			$('desktopContainer').appendChild(ifr);
		}
		else
		{
			$("iframe_"+items.id).src=items.url;
		}
		var ifr=$("iframe_"+items.id);
		var mousedownFn=function(ev,win)
                {
					
						for(var i in PW.Menu.all){PW.Menu.all[i]?PW.Menu.all[i].remove?PW.Menu.all[i].remove():0:0;}
						try{startPanelShow.remove();}catch(e){}
					//!IE?event.cancelBubble=true:0;
                };
				var allIframes=[ifr];
        for (var i = 0,len = allIframes.length; i < len; i++)
        {
            cwin = allIframes[i].contentWindow;
            if (cwin.document)
            {
                cwin.document.onmousedown =function(ev){mousedownFn(ev||event,cwin)};
            }
			var onloadFn=function()
			{

				try{setTimeout(function(){cwin.focus();},1000);}catch(e){}
				return function()
				{
					cwin.document.onmousedown =function(ev){mousedownFn(ev||event,cwin)};
				};
			};
			onloadFn=onloadFn.call(cwin);
			allIframes[i].detachEvent("onload",onloadFn);
            allIframes[i].attachEvent("onload",onloadFn);

        }
        if (PW.Window.all[items.id])
        {
			
			var b=PW.Window.all[items.id];
			mousedownFn();
        }
		else
		{
			var b = new PW.TaskButton();
			
		}
       

		PW.Window.all[items.id]=b;
        b.id = items.id;

		/**
		 *当任务栏的按钮被删除时触发此方法，来删除对应的iframe窗口
		 */

		b.onremove =function()
		{
			$removeNode(ifr);
		};
        b.text = items.name;
        b.width = 110;
		/**
		 *当点击了任务栏的按钮后，触发此方法。
		 */
        b.onclick = function()
        {
            ACTIVEDBUTTON ? ACTIVEDBUTTON.blur() : 0;
            ifr.style.display="";
			b.focus();
        };

		/**
		 *当聚焦到按钮时，触发该方法
		 */
        b.onfocus = function()
        {
			ifr.style.display="";
            $('taskbar').scrollTop = IE ? b.element.offsetTop: _getPos(b.element)[1] - _getPos($('taskbar'))[1] ;
			
			
        };
		/**
		 *当按钮失去焦点时，触发此方法。
		 */
		b.onblur=function()
		{
			ifr.style.display="none";
		};
        b.render($('taskbar'));
		this.button=b;
		b.element.self=b;
		/**
		 *在按钮被删除前，触发该方法，做一些切换邻近按钮的工作
		 */
		b.onbeforeremove = function(){var e=b.element.previousSibling||b.element.nextSibling;e?e.self.onclick():0;};
		
        $('taskbar').scrollTop = $('taskbar').scrollHeight;
        items.onclick ? items.onclick(items) : 0;
		b.focus();
		/**
		 *为了兼容老的代码，这里故意封装为对象返回。
		 */
		return {loadIframe:function(){ifr.src=items.url;return {ifr:ifr}},ifr:ifr};
    };
} ();