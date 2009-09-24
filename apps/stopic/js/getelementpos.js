var getElementPos = Class({},{
	Create	: function (elementId) {
		if (typeof(elementId)=='string') {
			this.element = getObj(elementId);
		} else {
			this.element = elementId;
		}
		this.x = 0;
		this.y  = 0;
		this._init();
	},
	getX	: function () {
		return this.x;
	},
	getY	: function () {
		return this.y;
	},
	_init	: function () {
		this.width = this.element.offsetWidth;
		this.height = this.element.offsetHeight;
		if(this.element.offsetParent){
			while(this.element.offsetParent){
				this.x += this.element.offsetLeft;
				this.y += this.element.offsetTop - this.element.scrollTop;
				this.element = this.element.offsetParent;
			}
		} else if(this.element.x){
			this.x += this.element.x;
			this.y += this.element.y;
		}
		this.x	-= ietruebody().scrollLeft;
		this.y  -= ietruebody().scrollTop;
	}
}
);