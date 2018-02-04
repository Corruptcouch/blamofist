package;
import entities.Player;
import environment.Parts;
import h2d.Bitmap;
import h2d.Layers;
import h2d.Sprite;
import h2d.filter.Bloom;
import hxd.App;
import hxd.Key;
import hxd.Pad;
import hxd.Res;

/**
 * ...
 * @author Jason Ristich
 */
@:publicFields
class Game extends App
{
	public static var LW = 13;
	public static var LH = 13;
	public static var RATIO = 32;
	
	static var LAYER_BG = 0;
	static var LAYER_ENT = 1;
	static var LAYER_PLAYER = 2;
	
	var gamePad: Pad;
	var currentLevel: Int;
	
	var title: Title;
	var bg : Sprite;
	
	var world: Layers;
	
	var way : Float = 1.;
	
	public var player : Player;
	
	var parts : Parts;
	
	override function init() {
		s2d.setFixedSize(LW * RATIO, LH * RATIO);
		currentLevel = 0;
		
		world = new Layers(s2d);
		world.filter = new Bloom(0.5, 0.2, 2, 3);
		
		bg = new Sprite(world);
		bg.filter = new h2d.filter.Blur(1, 3);
		bg.filter.smooth = true;
		var tbg = Res.background.lightblue.toTile();
		tbg.scaleToSize(LW * RATIO, LH * RATIO);
		new h2d.Bitmap(tbg, bg);
		
		gamePad = Pad.createDummy();
		Pad.wait(function (p) gamePad = p);
		
		title = new Title();
	}
	
	function initLevel() {		
		trace(currentLevel);
		if (currentLevel == 0) {
			return;
		}
		var sBigTile = Res.environment.starBig.toTile();
		sBigTile.scaleToSize(10, 10);
		var sSmallTile = Res.environment.starSmall.toTile();
		sSmallTile.scaleToSize(10, 10);
		var stiles = [sBigTile, sSmallTile];
		parts = new Parts(stiles);
		var x = (s2d.width / 2);
		var y = (s2d.height / 2);
		player = new Player(x, 180);
	}
	
	function nextLevel() {
		haxe.Timer.delay(function() {
			currentLevel++;
			initLevel();
		},0);
	}
	
	override function update( dt : Float) {
		if (parts != null) {
			parts.update(dt);
		}
		
		if (player != null) {
			player.update(dt);
		}
		
		if ( title != null && title.getAlpha() < 1 )  {
			title.setAlpha(title.getAlpha() - (0.01 * dt));
			if( title.getAlpha() < 0 ) {
				title.remove();
			}
		}

		if( title != null && title.getAlpha() == 1 ) {
			if ( Key.isPressed(Key.ESCAPE) ) {
				currentLevel = 0;
			}
			if ( Key.isPressed(Key.ESCAPE) 
				|| Key.isPressed(Key.SPACE) 
				|| gamePad.isPressed(hxd.Pad.DEFAULT_CONFIG.A) 
				|| gamePad.isPressed(hxd.Pad.DEFAULT_CONFIG.B) ) {
				title.setAlpha(0.99);
				nextLevel();
			}
		}
	}
	
	public static var inst : Game;
	
	static function main() 
	{
		#if js
		hxd.Res.initEmbed({compressSounds:true});
		#else
		hxd.res.Resource.LIVE_UPDATE = true;
		hxd.Res.initLocal();
		#end
		inst = new Game();
	}
	
}