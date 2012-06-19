package ca.confidant.soundWidget;
//
import nme.display.Sprite;
import nme.Assets;
import nme.Lib;
import nme.media.Sound;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.MouseEvent;
import nme.net.URLRequest;
import nme.media.SoundChannel;


#if (flash)
import nme.display.LoaderInfo;
import nme.net.SharedObject;
#elseif (nme || jeash)
import js.Cookie;
#end



class Main extends Sprite{
	private var bOn:BitmapData;
	private var bOff:BitmapData;
	private var s:Sprite;
	private var b:Bitmap;
	private var audioPath:String;
	private var theSound:Sound;
	private var soundChannel:SoundChannel;
	// constructor
	public function new(){
		super ();

		var audioOn:Bool;
		audioOn=getAudioEnabled();

		var s=new Sprite();
		bOn=Assets.getBitmapData("assets/soundOn.png", true);
		bOff=Assets.getBitmapData("assets/soundOff.png", true);
		s.addEventListener(MouseEvent.CLICK,onActorClicked);
		s.mouseEnabled=true;
		s.useHandCursor=true;
		s.buttonMode=true;


		if(audioOn==true){
			b=new Bitmap(bOn);
		} else {
			b=new Bitmap(bOff);
		}
		s.addChild(b);
		addChild(s);

		//get sound path:
		#if (flash)
			try{
				var p=nme.Lib.current.loaderInfo.parameters;
				audioPath=Std.string(p.audioPath);
			} catch( unknown : Dynamic ) {
			   trace("Unknown exception : "+Std.string(unknown));
			}
		#elseif (nme || jeash)
			try{
				audioPath = untyped __js__('myAudioPath');
			} catch( unknown : Dynamic ) {
			   trace("Unknown exception : "+Std.string(unknown));
			}

		#end
		//trace (audioPath);

		//now load the sound
		//var snd:Sound=new Sound();
		//snd.load(audioPath);
		var request:URLRequest = new URLRequest(audioPath);
		theSound = new Sound();
            //theSound.addEventListener(Event.COMPLETE, completeHandler);
           // theSound.addEventListener(Event.ID3, id3Handler);
            //theSound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            //theSound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            theSound.load(request);
			if(audioOn){
				soundChannel=theSound.play();
			}

	   // var r = new haxe.Http(audioPath);
	    //r.onError = js.Lib.alert;
	    //r.onData = function(r) { makeAudio(r); }
	   // r.request(false);

	}
	private function makeAudio(r:Dynamic):Void{
		//trace("okay");
		var sound:Sound = cast(r,Sound);
		sound.play ();
	}
	private function onActorClicked(e:MouseEvent):Void{
		var a=e.currentTarget;
		//trace(a.name);
		if(b.bitmapData==bOn){
			setAudioEnabled("false");
			soundChannel.stop();
		} else {
			setAudioEnabled("true");
			soundChannel=theSound.play();
		}
	}
	private function setAudioEnabled(enable:String){
		#if (flash)
			var mySo:SharedObject;

            mySo = SharedObject.getLocal("IPPPaudioOn");

			mySo.data.savedValue = enable;

			if(mySo.data.savedValue=="false"){
				b.bitmapData=bOff;
			} else {
				b.bitmapData=bOn;
			}

		#elseif (nme || jeash)
			Cookie.set("IPPPaudioOn",enable);
			if(Cookie.get("IPPPaudioOn")=="false"){
				b.bitmapData=bOff;
			} else {
				b.bitmapData=bOn;
			}
			//trace("JS audio enabled:"+audioOn);
		#end
	}
	private function getAudioEnabled():Bool{
		var audioOn:Bool;
		#if (flash)
			var mySo:SharedObject;

            mySo = SharedObject.getLocal("IPPPaudioOn");

			//mySo.data.savedValue = "false";

			if(mySo.data.savedValue=="false"){
				audioOn=false;
			} else {
				audioOn=true;
			}

		#elseif (nme || jeash)
			if(Cookie.get("IPPPaudioOn")=="false"){
				audioOn=false;
			}else{
				audioOn=true;
			}
			//trace("JS audio enabled:"+audioOn);
		#end
		return audioOn;
	}
	// entry point
	public static function main() {
		Lib.current.addChild (new Main ());
	}
}
