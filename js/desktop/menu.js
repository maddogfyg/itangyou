/**
 *include Compatibility.js core.js
 *菜单类，用于创建无极限的菜单。
 继承自baseClass基类。
 使用方法：new PW.Menu(config).render();
 */
 ~
function()
{
    var ROOT = document.documentElement;
	var $=function(id){return document.getElementById(id);};
	var ce=function(tag){return document.createElement(tag);};
	PW.Menu = baseClass.extend();
	PW.Menu.all={};
	var _MP=PW.Menu.prototype;
	_MP._createClass=function()
	{
		return new PW.Menu();
	};
    _MP.addItem = function(json,last)
    {
        if (json == "-")
        {
            var b = ce("DIV");
			var a = ce("DIV");
			b.appendChild(a);
			b.style.paddingLeft="16px";
            a.className = "menu-sep";
            this.self.appendChild(b);
            return;
        }
        var a = ce("A");
        a.href = "javascript:;";
        a.id = "menuItem_" + json.id;
		IE?a.setAttribute("hideFocus","true"):a.style.outline='none';
		
        a.innerHTML = json.name;
		a.disabled=json.disabled||false;
		var li=ce("li");
		li.appendChild(a);
		a.style.cursor="default";
		last||this.noArrow?li.style.border="0":0;
        this.self.appendChild(li);
        var _this = this;
		if(!json.items)
		{
			a.onclick = function()
			{
				if(this.disabled) return;
				_this.handler(json);
				event.cancelBubble = true;
				_this.remove();
				return false;
			};
		}
        else
        {
			var arrow=ce("span");
			arrow.className="menu_s2 fr";
			a.insertBefore(arrow,a.firstChild);
			
        }
		var showedMenu={};
        var showItems= function()
        {
            if (json.items&&showedMenu.id!=_this.id+"_"+a.id)
            {
                var b = _this._createClass();
                b.body = _this.body;
                var c = _this.getPos(this);
                b.id = _this.id+"_"+a.id;
                b.width = _this.width;
                b.left = c[0] + this.offsetWidth + 3 - b.body.offsetLeft-20;
                b.items = json.items;
				var fixtop=50;
                b.top = c[1] - b.body.offsetTop-28;
				
                b.render();	
				if(b.element.offsetTop>_this.ROOT.offsetHeight-b.element.offsetHeight-fixtop)
				{
					
					b.element.style.top=_this.ROOT.offsetHeight-b.element.offsetHeight-fixtop+"px";
				}
				showedMenu=b.id;
				_this.self.actived&&_this.self.actived!=b?_this.self.actived.remove():0;
				_this.self.actived=b;
				
            }
			else
			{
				if (typeof(_this.self.actived) != 'undefined'){
					_this.self.actived.remove();
				}
			}
       };
		a.onmouseover =showItems;
        return a;
    };
    _MP.removeItem = function(id)
    {
        this._remove($('menuItem_' + id));
    };
    _MP.getPos = function(d)
    {
        var e = [0, 0];
        var el = d;
        while (el)
        {
            if (el == this.ROOT) break;

            e[0] = e[0] + el.offsetLeft;
            e[1] = e[1] + el.offsetTop;
            el = el.offsetParent;
        }
        return e;
    };
    _MP.show = function()
    {
		var sty=this.menu.style;
		//with(this.menu.style)

        //{
			sty.display = "";
            sty.width = this.width + "px";
            sty.left = (this.left+this.width>this.ROOT.offsetWidth?this.ROOT.offsetWidth-this.width:this.left) + "px";
			var fixtop=100;
			if(this.top+this.menu.offsetHeight>this.ROOT.offsetHeight-37)
			{
				var tt=this.top-(this.ROOT.offsetHeight-this.menu.offsetHeight-fixtop)+47;
				this.arrow?this.arrow.style.top=tt+"px":0;
			}
            sty.top = (this.top+this.menu.offsetHeight>this.ROOT.offsetHeight-37?this.ROOT.offsetHeight-this.menu.offsetHeight-fixtop:this.top) + "px";
            sty.position = "absolute";
        //}
		
    };
    _MP._remove = function(el)
    {
		if(!el)return;
        var a = ce("DIV");
        a.appendChild(el);
        a.innerHTML = "";
        a = null;
    };
    _MP.onremoved = function()
    {};
    _MP.remove = function()
    {
        this._remove(this.menu);
		window.lastObj?this.menu.id.indexOf(lastObj.id)>0?lastObj=0:0:0;
		this.onremoved();
    };
	_MP.handler=function(items)
	{	
		items.onclick ? items.onclick.call(items) : 0;
		this.onclick?this.onclick():0;
	};
    _MP.render = function()
    {
        ROOT = document.body;
		var arrow;
        var _this = this;
        this.items = this.items || [];
        this.ROOT = ROOT;
        this.body = this.body || document.body;
        if ($("menu_" + this.id))
        {
            var a = $("menu_" + this.id);
			this.self=a.lastChild;
        } 
		else
        {
			
            var a = ce("div");

			a.style.position="relative";
			a.className="menuIndex";
			if(!$("arrow_div")&&!this.noArrow)
			{
			arrow=ce("DIV");
			arrow.className="menu_s";
			arrow.style.left="0px";
			arrow.id="arrow_div";
			
			a.appendChild(arrow);
			}
            a.id = "menu_" + this.id;
            //a.className = "gMenu";
            var b = ce("div");
			b.innerHTML="<div class=\"menu_top\">&nbsp;</div><div class=\"menu_bg\"><ul class=\"menu_li\"></ul></div><div class=\"menu_bottom\">&nbsp;</div>    </div>";
			
            //b.className = "gM_Warp gMenuOpt";
            this.self =b.getElementsByTagName("UL")[0];
            
            a.appendChild(b);
            this.body.appendChild(a);
			if(IE)
			{
				a.attachEvent("onmouseover",function()
				{
					 window.MOUSE_OVERED=1;
					 clearTimeout(window.MenuTimer);
				});
				a.attachEvent("onmouseout",function()
				{
					 window.MenuTimer=setTimeout(function(){
					 window.MOUSE_OVERED=0;
					 },30);
				});
			}
            var item, items;
            for (var i = 0,len = this.items.length; i < len; i++)
            {
                item = this.addItem(this.items[i],i==this.items.length-1);
				if(!item)continue;
                if (!this.items[i].items)
                {
                    items = _this.items[i];

                } 
				else
                {
                    item.onmousedown = function()
                    {
                        event.cancelBubble = true
                    };
                }
            }
			var top=parseInt(a.offsetHeight/2-18/2-20);
			arrow?(arrow.style.top=47+"px"):0;
			this.arrow=arrow;
            ROOT[a.id] ? ROOT.detachEvent("onmousedown", ROOT[a.id]) : 0;
            ROOT.attachEvent("onmousedown", ROOT[a.id] = function(evt)
            {
				var evt=(evt||event).srcElement;
				var el=evt.outerHTML||evt.parentNode.outerHTML;
				
				navigator.userAgent.toLowerCase().indexOf("firefox")>0?el=evt.innerHTML||evt.parentNode.innerHTML:0;
                if (b.innerHTML.toLowerCase().indexOf(el.toLowerCase())==-1)
                {
                    _this.remove();
                }
            });
        }
		PW.Menu.all[this.id]=this;
		this.menu = a;
		this.element=a;
		this.show();
		a.style.zIndex="10000001";
        
    };

} ();
	