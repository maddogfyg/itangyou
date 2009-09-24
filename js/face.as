import flash.net.FileReference;
import flash.net.FileReferenceList;
import flash.utils.ByteArray;
import com.adobe.images. * ;
//舞台属性设置
stage.align = StageAlign.TOP_LEFT;
stage.scaleMode = StageScaleMode.EXACT_FIT;
stage.scaleMode = StageScaleMode.NO_SCALE;
var param: Object = root.loaderInfo.parameters;
var FileList: FileReference = new FileReference();
var UPLOAD_LIST: Array = [];
var selectBox: Sprite = new Sprite(); //生成选择框
var recordX: Number; //记录初始x坐标
var recordY: Number; //记录初始y坐标
var endX: Number; //记录结束x坐标
var endY: Number; //记录结束y坐标
var moveX: Number; //记录移动之后x坐标
var moveY: Number; //记录移动之后y坐标
var myImage: Bitmap; //显示图片的容器
var dragFlag: Boolean = false; //用于判断选择框是否正在拖动
var clickPoint: Point; //记录开始的选择框对应的舞台坐标点
var endPoint: Point; //记录选择框绘制结束后选择框对应的舞台坐标点
var jpgOut: BitmapData;
var TOTAL_FILE_SIZE;
var CURRENT_UPLOADED_SIZE;
var ALL_FILES_LENGTH;
var RENAME: Object =
{};
var WAST_TIME;
var USE_TIME;
_label.background = true;
maskerCover.background = true;
maskerCover.border=false;

addChild(_label);
masker.visible=true;

param['edit']?masker.visible=false:0;
var scale_: Number = view.width / view.height;
showTip(sendFile, "选择图片文件进行上传");

var imgsizeUnit: Number = Math.floor(param["imgsize"]);
    var unit: String = " KB";
    if (imgsizeUnit >= 1024)
    {
        imgsizeUnit = Math.floor(imgsizeUnit / 1024 * 100) / 100;
        unit = " MB";
    }
maxsize.text=imgsizeUnit+unit;
function uploadOneOk(event: DataEvent)
{
//alert("上传成功！uploadOneOk");
    UPLOAD_LIST[0].removeEventListener(ProgressEvent.PROGRESS, uploadOneProgress);
    UPLOAD_LIST[0].removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, arguments.callee);
    var filename: String = UPLOAD_LIST[0].name;
    UPLOAD_LIST.shift();
    
    if (ALL_FILES_LENGTH == 1)
    {
        var realFileName: String = event.data;
        realFileName.length>100?alert(realFileName):0;
        
        
        
        var img2:Loader=new Loader();
        img2.load(new URLRequest(realFileName));
        /**
         *img2.addEventListener(HTTPStatusEvent.HTTP_STATUS,function(event:HTTPStatusEvent):void {
        (""+event).indexOf("200")>=0?"":alert(""+event);
        });
         */
        img2.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event)
        {
            //  mc_image.scaleMode = StageScaleMode.NO_SCALE;
            /**
             *if(mc_image.width>img2.contentLoaderInfo.width&&mc_image.height>img2.contentLoaderInfo.width)
            {
                 mc_image.x=(mc_image.width-img2.contentLoaderInfo.width)/2;
                 mc_image.y=(mc_image.height-img2.contentLoaderInfo.height)/2;
                mc_image.height=img2.contentLoaderInfo.height;
                mc_image.width=img2.contentLoaderInfo.width;
               
            }
             */
             uploadOK.visible=true;
             showOperatorTool(true);
        masker.visible=false;
    progressbar.visible=false;
    uploadInfo.visible=false;
    selectBox.visible=true;
            //alert("返回值："+realFileName);
        });
        mc_image.load(new URLRequest(realFileName));
         thumbWhole();
      
    }
}
function showOperatorTool(flag)
{
    selectBox.visible=flag;
    dragCor.visible=flag;
    masker.visible=flag;
    progressbar.visible=flag;
}
function uploadOneProgress(event: ProgressEvent)
{
    var totalLength: String = "||||||||||||||||||||||||||||||||";
    CURRENT_UPLOADED_SIZE += event.bytesLoaded;
    var percent: Number = Math.floor(event.bytesLoaded / event.bytesTotal* 100);
    var upLoadInfo: String = "已上传 " + (percent==100?99:percent) + "%";
    uploadInfo.text = upLoadInfo;
    currentSendFileTime = new Date().getTime();
}
function uploadComplete(e:Event)
{
//alert("上传成功！uploadComplete");
}
var currentSendFileTime = 0;
var sendFileTimeout;
function startUpload(file: FileReference)
{
    CURRENT_UPLOADED_SIZE = 0;
    file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadOneOk);
    file.addEventListener(ProgressEvent.PROGRESS, uploadOneProgress);
    file.addEventListener(Event.COMPLETE, uploadComplete);
     file.addEventListener(SecurityErrorEvent.SECURITY_ERROR,function(event:SecurityErrorEvent):void {
        alert(""+event);
        });
    file.addEventListener(HTTPStatusEvent.HTTP_STATUS,function(event:HTTPStatusEvent):void {
        (""+event).indexOf("200")>=0?"":alert(""+event);
        });
    file.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void {
        alert(""+event);
        });
    var randomF: String = "" + new Date().getTime();
    var uploadPath=param['up'] || "/php/upload.php?";
    //alert(uploadPath);
    var uploadURL: URLRequest = new URLRequest(uploadPath.split("?")[0]+"?rtime&="+Math.random());
    var postdata:URLVariables=new URLVariables();
    
    var params=uploadPath.slice(uploadPath.indexOf("?")+1).split("&");
    var arg="";
    var teststr="";
    for(var i=0;i<params.length;i++)
    {
        arg=params[i].split("=");
        postdata[arg[0]]=arg[1]||"";
    }
    uploadURL.data=postdata;
    RENAME[file.name] = randomF + "_" + encodeURI(file.name);
    //uploadURL.url = (param['up'] || "/php/upload.php?") +"&filename=" + randomF + "_" + encodeURI(file.name);
    uploadURL.method = URLRequestMethod.POST;
    param['target']?navigateToURL(uploadURL,param['target']):"";
    try
    {
        file.upload(uploadURL);
    }
    catch(e:Error)
    {
        alert(e.message);
    }
}
function startTransFile()
{
    uploadInfo.visible=true;
    masker.visible=true;
    maskerCover.visible=false;
    selectBox.visible=false;
    WAST_TIME = new Date().getTime();
    startUpload(UPLOAD_LIST[0]);
}
var FILE_NAME:String;
function onFrlResult(event: Event) : void
{
    var fileStr: String = "";
    var size: int = 0;
    var info: String = "";
    progressbar.visible=true;
    ALL_FILES_LENGTH = 1;//FileList.fileList.length;
    for(var i=0;i<ALL_FILES_LENGTH;i++)
    {
        fileStr += FileList.name + ";";
        size += FileList.size;
        UPLOAD_LIST.push(FileList);
	/**
     *fileStr += FileList.fileList[i].name + ";";
	size += FileList.fileList[i].size;
	UPLOAD_LIST.push(FileList.fileList[i]);
     */
    }
   FILE_NAME=fileStr.slice(0,-1); 
    TOTAL_FILE_SIZE = size;
    if(size>param['imgsize']*1024)
    {
        maskerCover.visible=true;
        file_text.htmlText="<font color='#FF0000' size='16px'>文件大小超过限制</font>";
        return 
    }
    disableSave.visible=false;
    //var ext: String = FileList.name.split(".").pop();
    var file_selected_size: Number = Math.floor(size / 1024 * 10) / 10;
    var unit: String = "KB";
    if (file_selected_size > 1024)
    {
        file_selected_size = Math.floor(file_selected_size / 1024 * 100) / 100;
        unit = "MB";
    }
    info = fileStr.substr(0, -1) + " 共<font color='#FF0000'>" + file_selected_size + "</font>" + unit;
    file_text.htmlText = info;
    startTransFile();
}
function selectFile()
{
    uploadOK.visible=false;
    
    FileList.addEventListener(Event.SELECT, onFrlResult);
    var fileFilter: FileFilter = new FileFilter("图片文件", "*.gif;*.jpg;*.png;*.jpeg");
    FileList.browse([fileFilter]);
}
sendFile.addEventListener(MouseEvent.CLICK,
function(evt: MouseEvent)
{;
    selectFile();;
});

function resetThumb(event: Event)
{      
var scal:Number=mc_image.width/mc_image.height;
	if(scal>1)
	{
	
	selectBox.height = mc_image.height;
	selectBox.width = selectBox.height*scal;
	}
	else
	{
	selectBox.width = mc_image.width;
	selectBox.height = selectBox.width/scal;
	
	}
        createJPG(mc_image, mc_image, mc_image.x, mc_image.y);
	initial?0:(viewImage.x=view.x-15);
        selectBox.width=view.width;
	selectBox.height=view.height;
	selectBox.x=mc_image.x+(mc_image.width-selectBox.width)/2;
	selectBox.y=mc_image.y+(mc_image.height-selectBox.height)/2;
        mc_image.removeEventListener(Event.COMPLETE, arguments.callee);
	recordX = selectBox.x;
	recordY = selectBox.y;
	toRightCorner();
}
function thumbWhole()
{
    mc_image.addEventListener(Event.COMPLETE,resetThumb);
}
var initial:Boolean=false;
initStage();
selectBox.doubleClickEnabled = true;
saveFace.addEventListener(MouseEvent.CLICK,
function(e: MouseEvent)
{
    createFile(e);
});
resetBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent)
{
initial=false;
resetThumb(e);
});
resetBtn.visible=false;
function toRightCorner(drag="")
{
drag=drag||dragCor;
drag.x=selectBox.x + selectBox.width - se_cursor.width+(drag==dragCor?-34:0);
drag.y=selectBox.y + selectBox.height - se_cursor.height+(drag==dragCor?21:0);
}
function initStage()
{
move_cursor.visible=false;
    myImage = new Bitmap();
    addChild(myImage);
    addChild(masker);
   
    mc_image.load(new URLRequest(param["url"]||"a.jpg"));
     uploadOK.visible=false;
     
	initial=true; 
    selectBox.graphics.clear();
    selectBox.graphics.lineStyle(1, 0x000000);
    selectBox.graphics.beginFill(0xffffff, 0.5);
    selectBox.graphics.drawRect(0, 0, mc_image.width, mc_image.height);
    selectBox.graphics.endFill();
    addChild(dragCor);
    addChild(selectBox);
    addChild(masker);
     addChild(maskerCover);
    mc_image.cacheAsBitmap = true;
selectBox.cacheAsBitmap = true;
    mc_image.filters = [new BlurFilter(0,0,0)];
    //mc_image.mask=selectBox;
    selectBox.x = mc_image.x;
    selectBox.y = mc_image.y;
    //showTip(selectBox, "双击保存选区头像");
    thumbWhole();
   showOperatorTool(false);
   masker.visible=true; 
    stage.addEventListener(MouseEvent.MOUSE_MOVE, function(e:Event)
    {
     if(dragFlag)
     {
     move_cursor.x=mouseX-move_cursor.width/2;
     move_cursor.y=mouseY-move_cursor.height/2;
     }
    dragFlag? toRightCorner():"";
    });
    mc_image_ref.addEventListener(MouseEvent.MOUSE_DOWN, startDraw); //绘制选择框
    mc_image.addEventListener(MouseEvent.MOUSE_DOWN, startDraw); //绘制选择框
    selectBox.addEventListener(MouseEvent.MOUSE_DOWN, dragSelectBox); //拖动选择框
    selectBox.addEventListener(MouseEvent.MOUSE_MOVE,
    function(e: MouseEvent)
    {
    Mouse.hide();
     move_cursor.x=mouseX-move_cursor.width/2;
     move_cursor.y=mouseY-move_cursor.height/2;
	toRightCorner();
    
        if (isCorner() || dragFlag)
        {
	if(!justDrag)
	{
            se_cursor.visible = true;
            move_cursor.visible=false;
            toRightCorner(se_cursor);
	    }
        } else
        {
            se_cursor.visible = false;
            move_cursor.visible=true;
           
        }
    }); //拖动选择框
    selectBox.addEventListener(MouseEvent.ROLL_OUT,
    function(e: MouseEvent)
    {
        if (!dragFlag)
        {
            Mouse.show();
            se_cursor.visible = false;
            move_cursor.visible=false;
        }
    }); //拖动选择框
    selectBox.addEventListener(MouseEvent.DOUBLE_CLICK, createFile); //剪切
    selectBox.addEventListener(MouseEvent.MOUSE_UP, stopDragSelectBox); //停止拖动选择框
}
function resizeDragCon(e: MouseEvent)
{
disableSave.visible=false;
    setSize(
    {
        mouseX: mouseX,
        mouseY: mouseY
    });
     toRightCorner();
    if (isOutRange(
    {
        mouseX: mouseX,
        mouseY: mouseY
    }))
    {
        return;
    }
    limitRect();
   
}
se_cursor.visible = false;
var justDrag=false;
function isCorner():Boolean
{
return selectBox.y + selectBox.height - mouseY < 15 && selectBox.y + selectBox.height - mouseY >= 0 && selectBox.x + selectBox.width - mouseX < 15 && selectBox.x + selectBox.width - mouseX >= 0
}
function dragSelectBox(_evt: MouseEvent) : void
{  disableSave.visible=false;

    if (isCorner())
    {
        se_cursor.startDrag();
	
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, resizeDragCon);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, resizeDragCon);
        stage.removeEventListener(MouseEvent.MOUSE_UP, endDraw);
        stage.addEventListener(MouseEvent.MOUSE_UP, endDraw);
	justDrag=false;
    } else
    {
        _evt.currentTarget.startDrag(false, new Rectangle(mc_image.x, mc_image.y, mc_image.width - selectBox.width, mc_image.height - selectBox.height)); //false,new Rectangle(mc_image.x,mc_image.y,mc_image.width,mc_image.height)
	justDrag=true;
    Mouse.hide();
        //move_cursor.startDrag();
    }
    toRightCorner();
    dragFlag = true;
}
function stopDragSelectBox(_evt: MouseEvent)
{
    if (dragFlag == true)
    {
        //Math.min(recordX,endX),Math.min(recordY,endY)
        createJPG(mc_image, selectBox, selectBox.x, selectBox.y);
        selectBox.stopDrag();
        //Mouse.show();
        move_cursor.visible=false;
        dragFlag = false;
	justDrag=false;
    }
}
//开始绘制
var width_: Number;
var height_: Number;
function startDraw(_evt: MouseEvent) : void
{
    disableSave.visible=false;
	dragCor.visible=false;
    stage.addEventListener(Event.ENTER_FRAME, drawSelectBox);
    recordX = mouseX;
    recordY = mouseY;
    recordX2=recordX;
    recordY2=recordY;
    width_ = selectBox.width;
    height_ = selectBox.height;
    clickPoint = new Point(recordX, recordY);
    stage.addEventListener(MouseEvent.MOUSE_UP, endDraw); // 鼠标在舞台上放开时的事件
}
function isOutRange(j: Object) : Boolean
{
    /**
 *if(j.mouseX<selectBox.x) return  true;
if(j.mouseY<selectBox.y) return  true;
if(j.mouseX>mc_image.width+mc_image.x) return  true;
if(j.mouseY>mc_image.height+mc_image.y) return  true;
 */
    return  false;
}
function limitRect()
{
    if (selectBox.x + selectBox.width > mc_image.x + mc_image.width)
    {
        selectBox.width = mc_image.x + mc_image.width - selectBox.x;
    }
    if (selectBox.y + selectBox.height > mc_image.y + mc_image.height)
    {
        selectBox.height = mc_image.y + mc_image.height - selectBox.y;
    }
    if (selectBox.x < mc_image.x)
    {
        selectBox.x = mc_image.x;
    }
    if (selectBox.y < mc_image.y)
    {
        selectBox.y = mc_image.y;
    }
        if(selectBox.width>selectBox.height*scale_)
    {
	selectBox.width=selectBox.height*scale_;
        toRightCorner();
    }
    if(selectBox.height>selectBox.width/scale_)
    {
	selectBox.height=selectBox.width/scale_;
	 toRightCorner();
    }
}
var recordX2:Number;
var recordY2:Number;
function setSize(j: Object)
{
var xx:Number;
var yy:Number;
	xx=recordX;
	yy=recordY;

    if (Math.abs(j.mouseX - xx) > Math.abs(j.mouseY - yy))
    {
    if(Math.abs(j.mouseX - xx)<30)
    {
      selectBox.width=30;
    }
    else
    {
        selectBox.width = Math.abs(j.mouseX - xx);
	}
        selectBox.height = selectBox.width / scale_;
    } else
    {
        selectBox.height = Math.abs(j.mouseY - yy);
        selectBox.width = selectBox.height * scale_;
    }
     if(Math.abs(j.mouseX - xx)<30)
    {
      selectBox.width=30;
    }
    if(Math.abs(j.mouseY - yy)<30)
    {
      selectBox.height=30;
    }

    
}
//绘制选择框
function drawSelectBox(_evt: Event) : void
{
    
    selectBox.x = selectBox.y = 0; //恢复坐标到原点
    if (isOutRange(
    {
        mouseX: mouseX,
        mouseY: mouseY
    }))
    {
        return;
    }
    setSize(
    {
        mouseX: mouseX,
        mouseY: mouseY
    });
    if (mouseX - recordX > 0)
    {
        selectBox.x = recordX;
    } else
    {
        selectBox.x = recordX - selectBox.width;
    }
    if (mouseY - recordY < 0)
    {
        selectBox.y = recordY - selectBox.height;
    } else
    {
        selectBox.y = recordY;
    }
    limitRect();
    toRightCorner();
    if(selectBox.width>dragCor.width)
    {
    dragCor.visible=true;
    }
    // }
}
//绘制结束
function endDraw(_evt: MouseEvent) : void
{
    Mouse.show();
    se_cursor.stopDrag();
    se_cursor.visible = false;
    stage.removeEventListener(Event.ENTER_FRAME, drawSelectBox);
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, resizeDragCon);
    selectBox.stopDrag();
    dragFlag = false;
    endX = mouseX;
    endY = mouseY;
    endPoint = new Point(endX, endY);
    createJPG(mc_image, selectBox, Math.min(recordX, endX), Math.min(recordY, endY));
    
    justDrag=false;
    stage.removeEventListener(MouseEvent.MOUSE_UP, endDraw); //鼠标在舞台上放开时的事件
}
var viewImage: MovieClip;
var scaled=false;
function createJPG(m: UILoader, box: Sprite, originX: Number, originY: Number)
{
    if (selectBox.width <= 0) return;
     
    viewImage ? removeChild(viewImage) : "";
    var jpgSource: BitmapData = new BitmapData(m.width, m.height); //先把背景图转换成BitmapData
    jpgSource.draw(m);
    var rect: Rectangle = new Rectangle(originX - mc_image.x, originY - mc_image.y, box.width, box.height); //设置复制的区域和大小
    var pt: Point = new Point(0, 0); //复制到的对象的起始点
    jpgOut = new BitmapData(selectBox.width, selectBox.height, true, 0);
    jpgOut.copyPixels(jpgSource, rect, pt); //复制区域内容
    myImage = new Bitmap(jpgOut);
    var maxS: Number = Math.max(view.width / selectBox.width, view.height / selectBox.height);
    myImage.scaleX = maxS;
    myImage.scaleY = maxS;
    myImage.smoothing = true;
    viewImage = new MovieClip();
    viewImage.smoothing = true;
    viewImage.addChild(myImage);
    addChild(viewImage);
    addChild(masker);
     addChild(maskerCover);
    recordX = selectBox.x;
    recordY = selectBox.y;
    viewImage.width=120;
    viewImage.height=120;
    viewImage.x = view.x + 1;
    viewImage.y = view.y + 1;
}
function createFile(event: MouseEvent = null)
{
    var a: JPGEncoder = new JPGEncoder(80);
    jpgOut = new BitmapData(view.width, view.height, true, 0);
    jpgOut.draw(viewImage);
    var bytesArr: ByteArray = a.encode(jpgOut);
    trace(JPGEncoder);
    var request: URLRequest = new URLRequest();
    //data值就为图片编码数据ByteArray;
    request.data = bytesArr;
    request.url = (param["saveFace"]||"php/makepic.php")+"&filename="+encodeURI(FILE_NAME);
    request.method = URLRequestMethod.POST;
    //这个是关键,内容类型必须是下面文件流形式;
    request.contentType = "application/octet-stream";
     var postdata:URLVariables=new URLVariables();
    
    var params=request.url.slice(request.url.indexOf("?")+1).split("&");
    var arg="";
    var teststr="";
    for(var i=0;i<params.length;i++)
    {
        arg=params[i].split("=");
        postdata[arg[0]]=arg[1]||"";
    }
   // request.data=postdata;
    return navigateToURL(request, "_self");
    /**
     *var loader: URLLoader = new URLLoader();
    loader.dataFormat = URLLoaderDataFormat.BINARY;
    loader.addEventListener(Event.COMPLETE, completeHandler);
    loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
     loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,function(event:SecurityErrorEvent):void {
        alert(""+event);
        });
    loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,function(event:HTTPStatusEvent):void {
        alert(""+event);
        });
    loader.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void {
        alert(""+event);
        });
    loader.load(request);
    function progressHandler(e: ProgressEvent) : void
    {
        //trace(int(Math.round(e.bytesLoaded / e.bytesTotal * 100)));
    }
    function completeHandler(e: Event) : void
    {
        navigateToURL(request, "_self");
        var fileName: String = String(e.currentTarget.data); // + '.jpg';
        trace('fileName: ' + fileName);
        var downloadURL: URLRequest = new URLRequest();
        //downloadURL.url = "http://fishbone:81"+fileName + "?" + Math.random();
        //var file:FileReference = new FileReference();
        //file.download(downloadURL);
    }
     */
}
function alert(Str: String)
{
    ExternalInterface.call("alert", Str);
}
//---------------
function showTip(obj, text)
{
    _label.autoSize = TextFieldAutoSize.LEFT;
    _label.selectable = false;
    obj.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
    obj.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
    obj.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
    var tipTimeout;
    function overHandler(event: MouseEvent) : void
    {
        addChild(_label);
        _label.visible = true;
        _label.htmlText = text;
        _label.width = text.length * 13 + 10;
        _label.x = event.stageX;
        _label.y = event.stageY - _label.height - 4;
        clearTimeout(tipTimeout);
        tipTimeout = setTimeout(function()
        {
            _label.visible = false;
        },
        2000);
    }
    function outHandler(event: MouseEvent) : void
    {
        _label.visible = false;
    }
    function moveHandler(event: MouseEvent) : void
    {
        _label.x = event.stageX;
        _label.y = event.stageY - _label.height - 4;
    }
}
//--------------
