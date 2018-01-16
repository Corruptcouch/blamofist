package;

import entities.Character;
import h2d.Bitmap;
import h2d.Layers;
import h2d.Sprite;
import h2d.Text;
import h2d.Tile;
import h2d.TileGroup;
import hxd.Key;
import hxd.Pad;
import hxd.Res;

class Game extends hxd.App
{
	static var PIXEL_SIZE = 16;

	static var LW = 13;
	static var LH = 13;

	static var LAYER_COLLIDE = 0;
	static var LAYER_PROJECTILE = 4;
	static var LAYER_ENEMY = 3;
	static var LAYER_CHARACTER = 2;
	static var LAYER_ENVIRONMENT = 1;

	var currentLevel : Int;

	var tiles : Tile;
	var world : Layers;
	var gamepad : Pad;
	var background : Sprite;
	var title : Bitmap;

	var overworldLayer: TileGroup;
	var caveLayer: TileGroup;
	var objectLayer: TileGroup;
	var insideStructureLayer: TileGroup;

	var characterLayer: TileGroup;

	var player: entities.Character;

	var bmpTrans : Bitmap;

	var collides : Array<Int> = [];

	override function init()
	{
		s2d.setFixedSize(LW * 32, LH * 32);
		currentLevel = 1;

		world = new Layers(s2d);
		world.filter = new h2d.filter.Bloom(0.5, 0.2, 2, 3);

		background = new Sprite(world);
		background.filter = new h2d.filter.Blur(1, 3);
		background.filter.smooth = true;

		world.add(overworldLayer, LAYER_ENVIRONMENT);
		world.add(characterLayer, LAYER_CHARACTER);

		gamepad = Pad.createDummy();
		Pad.wait(function(p) { gamepad = p; });

		//title = new Bitmap(Res.title.toTile(), world);
		//title.scale(0.75);

		var titleText = new Text(hxd.res.DefaultFont.get(), world);
		titleText.scale(0.5);
		titleText.textColor = 0;
		titleText.text = "Press space / A to start";
		titleText.x = ((LW * 32) - (titleText.textWidth * 2)) >> 1;
		titleText.y = 180;
	}

	function nextLevel()
	{
		haxe.Timer.delay(function()
		{

			background.visible = false;

			var t = new h3d.mat.Texture(LW * 31, LH * 32, [Target]);
			var oldWorldFilter = world.filter;
			world.filter = null;
			world.drawTo(t);
			world.filter = oldWorldFilter;

			bmpTrans = new Bitmap(Tile.fromTexture(t));

			background.visible = true;

			currentLevel++;
			initLevel();
			world.add(bmpTrans, LAYER_COLLIDE);
		}, 0);
	}

	function initLevel()
	{

	}

	override function update(dt: Float)
	{

		if (title != null && title.alpha == 1)
		{
			if (Key.isPressed(Key.ESCAPE))
			{

			}
			if (Key.isPressed(Key.SPACE) || gamepad.isPressed(hxd.Pad.DEFAULT_CONFIG.A))
			{
				title.alpha = 0.99;
				nextLevel();
			}
		}
	}

	public static var instance : Game;

	static function main()
	{
		Res.initEmbed();
		instance = new Game();
	}
}