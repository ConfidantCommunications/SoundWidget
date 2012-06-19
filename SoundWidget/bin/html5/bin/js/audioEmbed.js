var swfVersionStr = "9.0.115";
		
if (swfobject.getQueryParamValue("flash") != "0" && swfobject.hasFlashPlayerVersion(swfVersionStr)) {
	
	
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
	var app = document.createElement("script");
	app.setAttribute("type","text/javascript");
	app.setAttribute("src", "./SoundWidget.js");
	document.getElementsByTagName("head")[0].appendChild(app)
}