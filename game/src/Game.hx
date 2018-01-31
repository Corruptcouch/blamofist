package;
import entities.Player;
import entities.Entity;
import h2d.CdbLevel;
import h2d.Layers;
import h2d.Sprite;
import h2d.SpriteBatch;
import h2d.TileGroup;
import h2d.filter.Bloom;
import h2d.filter.Blur;
import hxd.App;
import db.Data;
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
	public static var RATIO = 32;
	
	static var LAYER_BG = 0;
	static var LAYER_COL = 1;
	static var LAYER_ENT = 2;
	static var LAYER_HERO = 3;
	
	public static var LW = 13;
	public static var LH = 13;
	
	var currentLevel: Int;
	var gamePad: Pad;
	
	var bmpTrans : h2d.Bitmap;
	var bg: Sprite;
	var world: Layers;
	var bgLayer: TileGroup;
	
	var player : entities.Player;
	
	var enemyKind: db.Data.EnemiesKind;
	var entities: Array<Entity> = [];
	
	var envPartKind: db.Data.EnvPartsKind;
	var parts: SpriteBatch;
	var way : Float = 1.;
	
	var level: db.Data.Levels;
	
	var title : Title;
	
	override function init() {
		s2d.setFixedSize(LW * RATIO, LH * RATIO);
		currentLevel = 0;
		
		world = new Layers(s2d);
		world.filter = new Bloom(0.5, 0.2, 2, 3);
		
		bgLayer = new TileGroup(Res.background.grey.toTile());
		
		bg = new Sprite(world);
		bg.filter = new Blur(1, 3);
		bg.filter.smooth = true;

		world.add(bgLayer, LAYER_BG);
		
		gamePad = Pad.createDummy();
		Pad.wait(function (p) gamePad = p);

		Res.data.watch(onReload);
		
		title = new Title();
	}
	
	function initLevel( ?reload ) {
		level = db.Data.levels.all[currentLevel];
		if (level == null) {
			return;
		}
		
		if( !reload ) {
			for( e in entities.copy() ) {
				e.remove();
			}
		}
		
		while (bgLayer.numChildren > 0) {
			bgLayer.getChildAt(0).remove();
		}
		
		var cdbLevel = new CdbLevel(db.Data.levels, currentLevel);
		cdbLevel.redraw();
		
		if (!reload) {
			var x = Std.int(LW * RATIO / 2); 
			var y = Std.int(LH * RATIO / 2);
			player = new entities.Player(x, y);
		}
	}
	
	function onReload() {
		Data.load(hxd.Res.data.entry.getText());
		initLevel(true);
	}
	
	function nextLevel() {
		haxe.Timer.delay(function() {
			currentLevel++;
			initLevel();
		},0);
	}
	
	override function update( dt : Float) {
		
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
			if( Key.isPressed(Key.ESCAPE) || Key.isPressed(Key.SPACE) || gamePad.isPressed(hxd.Pad.DEFAULT_CONFIG.A) || gamePad.isPressed(hxd.Pad.DEFAULT_CONFIG.B) ) {
				currentLevel--;
				title.setAlpha(0.99);
				nextLevel();
			}
		}
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