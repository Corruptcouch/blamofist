package;
import entities.Entity;
import h2d.CdbLevel;
import h2d.Layers;
import h2d.Sprite;
import h2d.SpriteBatch;
import h2d.SpriteBatch.BatchElement;
import h2d.Tile;
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
	static var LAYER_BG = 0;
	static var LAYER_ENT = 1;
	static var LAYER_HERO = 5;
	static var LAYER_ENVP = 7;
	
	public static var LW = 13;
	public static var LH = 13;
	
	var currentLevel: Int;
	var gamePad: Pad;
	
	var bmpTrans : h2d.Bitmap;
	var bg: Sprite;
	var world: Layers;
	var bgLayer: TileGroup;
	var entities: Array<Entity> = [];
	var parts: SpriteBatch;
	var level: db.Data.Levels;
	
	var title : h2d.Bitmap;
	
	override function init() {
		s2d.setFixedSize(LW * 32, LH * 32);
		currentLevel = 0;
		
		world = new Layers(s2d);
		world.filter = new Bloom(0.5, 0.2, 2, 3);
		
		gamePad = Pad.createDummy();
		Pad.wait(function (p) gamePad = p);
		
		//Res.data.watch(onReload);
		
		title = new h2d.Bitmap(Res.background.red.toTile(), world);
		title.scale(2);
		
		var tf = new h2d.Text(hxd.res.DefaultFont.get(), title);
		tf.scale(0.5);
		tf.textColor = 0xFFFFFF;
		tf.text = "Press space / A to start";
		tf.x = ((LW * 32) - (tf.textWidth * 2)) >> 1;
		tf.y = 180;
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
			bg.getChildAt(0).remove();
		}
		
		var cdbLevel = new CdbLevel(db.Data.levels, currentLevel);
		cdbLevel.redraw();
		
		bgLayer.clear();

		var tile = Res.environment.nebula.toTile();
		parts = new SpriteBatch(tile);
		world.add(new Sprite(parts), LAYER_ENVP);
		for( i in 0...10 )
			parts.add(new EnvPart(tile));
	}
	
	function onReload() {
		Data.load(hxd.Res.data.entry.getText());
		initLevel(true);
	}
	
	function nextLevel() {
		haxe.Timer.delay(function() {
			bg.visible = false;
			parts.visible = false;
			//if( hero != null ) hero.remove();

			var t = new h3d.mat.Texture(LW * 32, LH * 32, [Target]);
			var old = world.filter;
			world.filter = null;
			world.drawTo(t);
			world.filter = old;
			bmpTrans = new h2d.Bitmap(h2d.Tile.fromTexture(t));

			bg.visible = true;
			parts.visible = true;

			currentLevel++;
			initLevel();

			world.add(bmpTrans, LAYER_ENT - 1);

		},0);
	}
	
	override function update( dt : Float) {
	
		if( bmpTrans != null ) {
			bmpTrans.alpha -= 0.05 * dt;
			if( bmpTrans.alpha < 0 ) {
				bmpTrans.tile.getTexture().dispose();
				bmpTrans.remove();
				bmpTrans = null;
			}
		}
		
		if( title != null && title.alpha < 1 )  {
			title.alpha -= 0.01 * dt;
			if( title.alpha < 0 ) {
				title.remove();
				title = null;
			}
		}


		if( title != null && title.alpha == 1 ) {
			if( Key.isPressed(Key.ESCAPE) )
				currentLevel = 0;
			if( Key.isPressed(Key.ESCAPE) || Key.isPressed(Key.SPACE) || gamePad.isPressed(hxd.Pad.DEFAULT_CONFIG.A) || gamePad.isPressed(hxd.Pad.DEFAULT_CONFIG.B) ) {
				currentLevel--;
				title.alpha = 0.99;
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

class EnvPart extends BatchElement {

	public var speed : Float;
	public var rspeed : Float;

	public function new(t) {
		super(t);
		x = Math.random() * Game.LW * 32;
		y = Math.random() * Game.LH * 32;
		speed = 6 + Math.random() * 3;
		rspeed = 0.02 * (1 + Math.random());
	}
}