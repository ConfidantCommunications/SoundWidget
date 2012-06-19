var swfVersionStr = "9.0.115";
function supports_canvas() {
	return !!document.createElement('canvas').getContext;
}
function supports_mp3(){
	var a = document.createElement('audio');
	return !!(a.canPlayType && a.canPlayType('audio/mpeg;').replace(/no/, ''));

}

if(supports_canvas()&&supports_mp3()){
	var app = document.createElement("script");
	app.setAttribute("type","text/javascript");
	app.setAttribute("src", "./SoundWidgetMin.js");
	document.getElementsByTagName("head")[0].appendChild(app)
} else if (swfobject.hasFlashPlayerVersion(swfVersionStr)) {
	
	
	var xiSwfUrlStr = "expressInstall.swf";
	var flashvars = {
		audioPath:myAudioPath
	};
	
	var params = {};
	params.quality = "high";
	params.bgcolor = "#ffffff";
	params.play = "true";
	params.loop = "true";
	params.wmode = "transparent";
	params.scale = "showall";
	params.menu = "true";
	params.devicefont = "false";
	params.salign = "";
	params.allowFullScreen = "false";
	params.allownetworking = "true";
	params.allowscriptaccess = "always";
	
	var attributes = {};
	attributes.id = "theSound";
	attributes.name = "theSound";
	attributes.align = "middle";
	
	swfobject.embedSWF(
		"assets/SoundWidget.swf", "haxe:jeash", "800", "40",
		swfVersionStr, xiSwfUrlStr,
		flashvars, params, attributes);
} else {
	//No canvas or Flash support
}