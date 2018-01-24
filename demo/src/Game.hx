package;

import entities.Character;
import h2d.CdbLevel;
import h2d.Layers;
import h2d.Sprite;
import h2d.Tile;
import h2d.TileGroup;
import hxd.Pad;
import hxd.Res;

class Game extends hxd.App
{
	static var LAYER_COLLIDE = 0;
	static var LAYER_PROJECTILE = 4;
	static var LAYER_ENEMY = 3;
	static var LAYER_CHARACTER = 2;
	static var LAYER_ENVIRONMENT = 1;

	var currentLevel : Int;
	
	//var levels : Data.levels;
	var baseLayer : TileGroup;
	var tiles : Tile;
	var world : Layers;
	var gamepad : Pad;
	var background : Sprite;

	var player: entities.Character;


	override function init()
	{
		currentLevel = 1;

		world = new Layers(s2d);
		world.filter = new h2d.filter.Bloom(0.5, 0.2, 2, 3);
		
		var tiles = Res.data.Overworld.toTile();
		baseLayer = new TileGroup(tiles);
		
		background = new Sprite(world);
		background.filter = new h2d.filter.Blur(1, 3);
		background.filter.smooth = true;
		
		world.add(baseLayer, LAYER_ENVIRONMENT);
		
		gamepad = Pad.createDummy();
		Pad.wait(function(p) { gamepad = p; });
		
		initLevel();
	}

	function initLevel()
	{
		//levels = Data.levels.all[currentLevel];
		//if (levels = null) {
		//	return;
		//}
		
		var cdbLevel = new CdbLevel(Data.levels, currentLevel);
		cdbLevel.redraw();
		var layer = cdbLevel.getLevelLayer("overworld");
		if (layer != null) {
			baseLayer.addChild(layer.content);
		}
	}

	override function update(dt: Float)
	{
	}

	public static var instance : Game;

	static function main()
	{
		#if js
		hxd.Res.initEmbed({compressSounds:true});
		#else
		hxd.res.Resource.LIVE_UPDATE = true;
		hxd.Res.initLocal();
		#end
		instance = new Game();
	}
}