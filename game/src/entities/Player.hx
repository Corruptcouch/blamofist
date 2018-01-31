package entities;
import h2d.Anim;
import hxd.Key;
import hxd.Res;

/**
 * ...
 * @author Jason Ristich
 */
class Player extends Entity
{
	static var STEP = 8;
	
	var acc = 0.;
	
	var colX = -1;
	var colY = -1;
	
	public var lives: Array<Int> = [];
	public var inventory : Array<Entity> = [];
	var moving : { x : Int, y : Int, dx : Int, dy : Int, k : Float, way : Float };

	var spr: Anim;
	public var movingAmount : Float = 0.;
	var time : Float = 0.;
	
	var padActive : Bool = false;
	
	public function new(x, y) 
	{
		super(Player, x, y);
		colX = Std.int(this.x * STEP);
		colY = Std.int(this.y * STEP);
		spr = new Anim(getAnim(), 15);
		game.world.add(spr, Game.LAYER_HERO);
	}
	
	function getAnim() {
		var playerTile = Res.player.toTile();
		var playerLeftTile = Res.playerLeft.toTile();
		var playerRightTile = Res.playerRight.toTile();
		return [playerLeftTile, playerTile, playerRightTile];
	}
	
	function updateMove(dt:Float) {
		var left = Key.isDown(Key.LEFT) || game.gamePad.xAxis < -0.5;
		var right = Key.isDown(Key.RIGHT) || game.gamePad.xAxis > 0.5;
		var up = Key.isDown(Key.UP) || game.gamePad.yAxis < -0.5;
		var down = Key.isDown(Key.DOWN) || game.gamePad.yAxis > 0.5;

		if (left) {
			spr.x += STEP;
			trace("left");
		}
		if (right) {
			spr.x -= STEP;
			trace("right");
		}
		if (up) {
			spr.y += STEP;
			trace("up");
		}
		if (down) {
			spr.y -= STEP;
			trace("down");
		}
	}
	
	public function update(dt:Float) {
		updateMove(dt);
	}
}