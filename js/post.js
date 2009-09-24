var count = 1;
var menushow = '';
var picpath = imgpath+"/post/smile/";

var header = document.getElementsByTagName("head")[0];
var script = document.createElement("script");
script.src = 'js/lang/zh_cn.js';
header.appendChild(script);

document.write("<style>.face{ height:23px;padding:7px 0 0 8px;text-align:left;background:#E0F0F9 url("+imgpath+"/"+stylepath+"/th1.png);cursor:move}.face div{ width:56px;height:18px;text-align:center;padding:5px 0 0;cursor:pointer;}.face div.lian{ background:#ffffff url("+imgpath+"/"+stylepath+"/tag.jpg) no-repeat;cursor:auto;}</style>");
if(window.ActiveXObject){
	document.documentElement.addBehavior("#default#userdata");
}
for(var id in faces[defaultface]){
	var imgid = faces[defaultface][id];
	menushow += '<img src="'+imgpath+'/post/smile/'+face[imgid][0]+'" title="'+face[imgid][1]+'" onclick="addsmile('+imgid+');" style="cursor:pointer;margin:3px;" />';
	if(++count>fc_shownum)break;
}
if (objCheck(getObj("menu_show"))) {
	getObj("menu_show").innerHTML = menushow;
}

/**** myshow start****/
var myshow    = 'http://rs.phpwind.net/';
var showid    = "gb_0";
var subjectid = "200";

function addgeneralface(NewCode){
	if(typeof WYSIWYD == 'function'){
		
		if(editor._editMode=='textmode'){
			editor.focusEditor();
			AddText('[img]','');
			AddText(NewCode + '[/img]','');
		} else{
			editor.restoreRange();
			editor.insertHTML('<img src="' + NewCode + '" />');
		}
	} else{
		document.FORM.atc_content.value += ' [img]'+NewCode+'[/img] ';
	}
}
function setEmotionPos ()
{  

	try{var t=document.documentElement.scrollTop||document.body.scrollTop;getObj('wy_emotion')?(getPWBox().style.left=Object.GLOBAL_XY[0]+"px")+(getPWBox().style.top=Object.GLOBAL_XY[1]+t+5+"px"):0;}catch(e){}
}
function showGeneral(){
	
	if(!IsElement('generalbuttons')){
		read.obj = getObj("td_generalface");
		read.guide();
		setEmotionPos();
		ajax.send('pw_ajax.php?action=showsmile&type=general&subjectid=0','',initGeneralFace);
	} else{
		read.open('menu_generalface','td_generalface','2');
		showGeneralFace(showid,subjectid);
		setEmotionPos();
	}

}
function showGeneralFace(a,b){
	var s = getObj("showgeneralface");
	
	s.innerHTML = showLoading();
	
	showid    = a;
	subjectid = b;
	ajax.send('pw_ajax.php?action=showsmile&type=general&subjectid='+subjectid,'',initGeneralFaces);
}
function initGeneralFaces(){

	var response = ajax.XmlDocument();
	var generalfaceid   = new Array();
	var generalfacename = new Array();
	var generalfacetype = new Array();
	var generalfacecode = new Array();
	var node = response.getElementsByTagName('items')[0].childNodes;
	var j=0;
	for(var i=0;i<node.length;i++){
		try{
			generalfaceid[j]   = node[i].getAttribute('id');
			generalfacename[j] = node[i].getAttribute('name');
			generalfacetype[j] = node[i].getAttribute('type');
			generalfacecode[j] = node[i].getElementsByTagName('code').item(0).firstChild.nodeValue;
			j++;
		}catch(e){}
	}
	selectMenu("generalbuttons",showid);

	var s = document.getElementById("showgeneralface");
	for(i in generalfaceid){
		var sid = generalfaceid[i];
		var pic = document.createElement("img");
		pic.style.margin = "3px";
		pic.style.cursor = 'pointer';
		pic.id = sid;
		pic.title=generalfacename[i];
		pic.src = myshow+generalfacecode[i]+'G.gif';
		pic.onclick = function(){addgeneralface(this.src);closep();};
		s.appendChild(pic);
	}
	
	getObj("loading").style.display = "none";

}
function initGeneralFace(){
	var response = ajax.XmlDocument();
	var generalfaceid   = new Array();
	var generalfacename = new Array();

	var node = response.getElementsByTagName('subject')[0].childNodes;
	var j=0;
	for(var i=0;i<node.length;i++){
		try{
			generalfaceid[j] = node[i].getAttribute('id');
			generalfacename[j] = node[i].getAttribute('name');
			j++;
		}catch(e){}
	}
	var num = 0;
	var b='<span style="float:right;margin-right:3px;width:auto;cursor:pointer" onclick="closep();" title="close"><img src='+imgpath+'/close.gif></span>';
	for(f in generalfaceid){
		b += '<div id="gb_'+num+'" style="float:left" unselectable="on" onclick="showGeneralFace(\'gb_'+num+'\','+generalfaceid[f]+');">'+generalfacename[f]+'</div>';
		num++;
	}
	var a = {id:'menu_generalface',bid:'generalbuttons',sid:'showgeneralface',width:'300',height:'200',bhtml:b,shtml:''};
	initMenuTab(a,"4","1");
	read.open('menu_generalface','td_generalface','2');
	setEmotionPos();
	subjectid = generalfaceid[0];
	showGeneralFace(showid,generalfaceid[0]);
}
/**** myshow end****/
function showDefault(){
	if(!IsElement('buttons')){
		read.obj = getObj("td_face");
		read.guide();
		initFace();
	}
	read.open('menu_face','td_face','2');
	showFace("bts_0",defaultface);
}
function initFace(){
	var num=0;
	var b='<span style="float:right;margin-right:3px;width:auto;cursor:pointer" onclick="closep();" title="close"><img src='+imgpath+'/close.gif></span>';
	for(f in facedb){
		b += '<div id="bts_'+num+'" style="float:left" unselectable="on" onclick="showFace(\'bts_'+num+'\',\''+f+'\');">'+facedb[f]+'</div>';
		num++;
	}
	var a = {id:'menu_face',bid:'buttons',sid:'showface',width:'300',height:'200',bhtml:b,shtml:''};
	initMenuTab(a,"4","1");
}
function showFace(id,path){
	selectMenu("buttons",id);
	var s = getObj("showface");
	s.innerHTML = '';
	for(var i in faces[path]){
		var sid = faces[path][i];
		var pic = document.createElement("img");
		pic.style.margin = "3px";
		pic.style.cursor = "pointer";
		pic.id = sid;
		pic.onclick = function(){ 
			
			addsmile(this.id);
			setTimeout(closep,100);

		};
		pic.src = picpath+face[sid][0];
		pic.title = face[sid][1];
		s.appendChild(pic);
	}
   setEmotionPos();
}
function strlen(str){
	var len = 0;
	var s_len = str.length = (is_ie && str.indexOf('\n')!=-1) ? str.replace(/\r?\n/g, '_').length : str.length;
	var c_len = charset == 'utf-8' ? 3 : 2;
	for(var i=0;i<s_len;i++){
		len += str.charCodeAt(i) < 0 || str.charCodeAt(i) > 255 ? c_len : 1;
	}
	return len;
}
function quickpost(event){
	var keyDownCode = (event.which != undefined) ? event.which : event.keyCode;

	if((event.ctrlKey && keyDownCode == 13) || (event.altKey && keyDownCode == 83)){
		document.FORM.Submit.click();
	}
}
function saveData(key,value){
	if(!value) return;
    if (window.ActiveXObject) {
		with(document.documentElement) try {
			load(key);
			setAttribute("value", value);
			save(key);
			return getAttribute("value");
		} catch(e) {return;}
    } else if (window.sessionStorage) {
    	try {
			sessionStorage.setItem(key,value);
        } catch(e) {return;}
    }
}
function loadData(key){
	var msg = Session.get(key);
	if (!msg) {
		alert(I18N['loaddata_msg_none']);
		return false;
	} else if (typeof WYSIWYD == 'undefined' && document.FORM.atc_content.value != '' || typeof WYSIWYD == 'function' && editor.getHTML() != '') {
		if (!confirm(I18N['loaddata_confirm'])) {
			return false;
		}
	}
	setEditorContent(msg);
}
/*
 * 设置编辑器的内容
 *
 */
function setEditorContent (msg)
{
	msg=msg||"";
	if (typeof WYSIWYD == 'function' && editor._editMode == 'wysiwyg') {
		editor._doc.body.innerHTML = msg;

	} else {
		document.FORM.atc_content.value = msg;
	}
}
window.onunload = function() {
	saveData('msg',document.FORM.atc_content.value);
}
function savedraft() {
	if (typeof WYSIWYD == 'function') {
		var msg = editor._editMode == "textmode" ? editor.getHTML() : htmltocode(editor.getHTML());
	} else {
		var msg = document.FORM.atc_content.value;
	}
	ajax.send('pw_ajax.php','action=draft&step=2&atc_content='+ajax.convert(msg),ajax.guide);
}
function opendraft(id) {
	if (typeof draft == 'object') {
		sendmsg('pw_ajax.php','action=draft',id);
	} else {
		loadjs('js/pw_draft.js');
		setTimeout("opendraft('"+id+"')",300);
	}
}
function initMenuTab(arr,n,Y) {
	var m = getObj(arr["id"]);
	var b = document.createElement("div");
	var s = document.createElement("div");
	var c = document.createElement("div");
	m.className	       = "menu";
	b.id               = arr["bid"];
	b.className        = "face";
	b.style.width      = arr["width"]+"px";
	s.id               = arr["sid"];
	s.style.background = "#fff";
	if(Y)s.style.overflowY  = "auto";
	s.style.width      = (parseInt(arr["width"])+8)+"px";
	s.style.height     = arr["height"]+"px";
	s.innerHTML        = arr["shtml"];
	c.style.cssText    = "clear:both";
	m.appendChild(b);
	m.appendChild(c);
	m.appendChild(s);
	b.innerHTML = '<span style="float:left;cursor:pointer" onclick="showTab(\''+arr["bid"]+'\',-1,'+n+');"><img src="'+imgpath+'/wind/btLeft.gif" /></span>' + arr["bhtml"] + '<span style="float:right;cursor:pointer;margin-right:5px" onclick="showTab(\''+arr["bid"]+'\',1,'+n+');"><img src="'+imgpath+'/wind/btRight.gif" /></span>';
	showTab(arr["bid"],0,n);

}
function showTab(id,p,n){
	var o = getObj(id);
	var f = o.getElementsByTagName("div");
	var s = 0;
	for(i=0;i<f.length;i++)
		if(f[i].style.display != "none"){s = i;break;}
	s += p;
	if(s<0 || s+n>f.length)return;
	for(i=0;i<f.length;i++){
		if(i>=s && i<s+n){
			f[i].style.display = "inline";
		} else{
			f[i].style.display = "none";
		}
	}
	return;
}
function selectMenu(id,sid){
	var b = getObj(id);
	b.onmousedown = read.move;
	var f = b.getElementsByTagName("div");
	for(var i=0;i<f.length;i++){
		if(f[i].id==sid){
			f[i].className = "lian";
		} else{
			f[i].className = "";
		}
	}
}
function showLoading(){
	return "<div id=\"loading\" style=\"padding:20px;width:80%;text-align:center\"><img src=\""+imgpath+"/loading.gif\" align=\"absbottom\" /> 正在加载数据...</div>";
}