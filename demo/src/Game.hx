package;

import entities.Character;
import h2d.Layers;
import h2d.Sprite;
import hxd.Key;
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
	
	var levels : dat.Data.Blamofist;
	
	var world : Layers;
	var gamepad : Pad;
	var background : Sprite;

	var player: entities.Character;


	override function init()
	{
		currentLevel = 1;

		world = new Layers(s2d);
		world.filter = new h2d.filter.Bloom(0.5, 0.2, 2, 3);
		
		background = new Sprite(world);
		background.filter = new h2d.filter.Blur(1, 3);
		background.filter.smooth = true;

		gamepad = Pad.createDummy();
		Pad.wait(function(p) { gamepad = p; });
	}

	function initLevel()
	{

	}

	override function update(dt: Float)
	{
	}

	public static var instance : Game;

	static function main()
	{
		Res.initEmbed();
		instance = new Game();
	}
}