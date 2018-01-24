package;
import h2d.CdbLevel;
import h2d.Layers;
import h2d.Sprite;
import h2d.TileGroup;
import h2d.filter.Bloom;
import h2d.filter.Blur;
import hxd.App;
import db.Data;
import hxd.Pad;
import hxd.Res;
/**
 * ...
 * @author Jason Ristich
 */
class Game extends App
{
	static var LAYER_BG = 0;
	static var LAYER_ENT = 1;
	static var LAYER_HERO = 5;
	
	static var LW = 50;
	static var LH = 50;
	
	var currentLevel: Int;
	var gamePad: Pad;
	
	var bg: Sprite;
	var world: Layers;
	var bgLayer: TileGroup;
	
	//var level: db.Data.;
	
	override function init() {
		s2d.setFixedSize(LW * 16, LH * 16);
		currentLevel = 0;
		
		world = new Layers(s2d);
		world.filter = new Bloom(0.5, 0.2, 2, 3);
		
		bgLayer = new TileGroup(Res.Overworld.toTile());
		
		bg = new Sprite(world);
		bg.filter = new Blur(1, 3);
		bg.filter.smooth = true;
		
		world.add(bgLayer, LAYER_BG);
		
		gamePad = Pad.createDummy();
		Pad.wait(function (p) gamePad = p);
		
		Res.data.watch(onReload);
		
		initLevel();
	}
	
	function initLevel( ?reload ) {
		//level = db.Data.levelData.all[currentLevel];
		//if (level == null) {
		//	return;
		//}
		
		//var cdbLevel = new CdbLevel(db.Data.levelData, currentLevel);
		//cdbLevel.redraw();
		
		
		//while (bgLayer.numChildren > 0) {
		//	bg.getChildAt(0).remove();
		//}
	}
	
	function onReload() {
		Data.load(hxd.Res.data.entry.getText());
		initLevel(true);
	}
	
	public static var inst : Game;

	static function main() {
		#if js
		hxd.Res.initEmbed({compressSounds:true});
		#else
		hxd.res.Resource.LIVE_UPDATE = true;
		hxd.Res.initLocal();
		#end
		Data.load(hxd.Res.data.entry.getText());
		inst = new Game();
	}
}