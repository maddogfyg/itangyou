/**
 *include Compatibility.js core.js inherit from PW.Button
 *任务栏按钮类，继承自button基类
 */
 ~
function()
{
	PW.TaskButton = PW.Button.extend();
	var TASKBUTTONCOUNT=0;
	ACTIVEDBUTTON='';
	var _TP=PW.TaskButton.prototype;
	_TP.template="<span class=skipText>{text}</span><img src=js/desktop/images/close.gif style=cursor:pointer;display:none;position:absolute;left:90px;top:7px>"; 
	_TP.onfocus=function(){};
	_TP.onblur=function(){this.actived=false;this.element.className="btn-big btn-big-out";};
	_TP.focus=function()
	{
		 this.element.lastChild.style.display="";
		 if(ACTIVEDBUTTON&&ACTIVEDBUTTON!=this)
		{
			 ACTIVEDBUTTON.blur();
			 ACTIVEDBUTTON.element.className="btn-big btn-big-out";
		}
		 this.actived=true;
		 ACTIVEDBUTTON=this;
		 ACTIVEDBUTTON.element.className="btn-big btn-big-over";
		 this.onfocus();
	};
	_TP.blur=function()
	{
		if(this.element.lastChild)
		{
			 this.element.lastChild.style.display="none";
			 
			 this.onblur();
		}
	};
	_TP.onbeforeremove=function(){};
	_TP.remove=function()
	{
		this.onbeforeremove();
		$removeNode(this.element);
		this.onremove();
		TASKBUTTONCOUNT--;
	};
	_TP.close=function()
	{
		this.remove();
	};
	_TP.oncontextmenu=function()
	{

	};
	_TP._addClickEvent=function()
	{
		TASKBUTTONCOUNT++;
		this.focused=true;
		var _this=this;
		this.onclick?this.element.onclick=function(){_this.onclick()}:0;
		this.element.oncontextmenu=function()
		{
			_this.oncontextmenu({clientX:event.clientX,clientY:event.clientY});
			event.returnValue=false;
			return false;
		};
		this.element.attachEvent("onmouseover",function()
		{
			//_this.element.lastChild.style.display="";
		});
		this.element.attachEvent("onmouseout",function()
		{
			//_this.element.lastChild.style.display="none";
		});
		this.element.lastChild.onclick=function(){event.cancelBubble=true;_this.remove()};
	};
} ();
	