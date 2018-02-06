package entities;
import h2d.Anim;
import hxd.Key;
import hxd.Res;

/**
 * ...
 * @author Jason Ristich
 */
class Player 
{
	var game : Game;
	
	public var x : Float;
	public var y : Float;
	
	public var sprite : h2d.Bitmap;
	
	var time: Float = 0.;
	
	public var movingAmount : Float = 0.;
	
	public function new(x,y) 
	{
		game = Game.inst;
		this.x = x;
		this.y = y;
		sprite = new h2d.Bitmap(Res.player.idle.toTile());
		sprite.scale(0.25);
		sprite.tile.dx = -50;
		sprite.tile.dy = -50;
		game.world.add(sprite, Game.LAYER_PLAYER);
	}
	
	public var padActive = false;
	
	var rotationSpeed = 0.1;
	
	function updateMovement(dt:Float) {
		var left = Key.isDown(Key.LEFT) || game.gamePad.xAxis < -0.5;
		var right = Key.isDown(Key.RIGHT) || game.gamePad.xAxis > 0.5;
		var up = Key.isDown(Key.UP) || game.gamePad.yAxis < -0.5;
		var down = Key.isDown(Key.DOWN) || game.gamePad.yAxis > 0.5;
		
		if (up) {
			var y = game.s2d.width / 2;
			var x = game.s2d.height;
			var angle = Math.atan2(y - sprite.y, x - sprite.x);
			trace("UP: " + x + " " + y + " : " + angle);
			sprite.rotation = angle;
			
		}
		
		if (down) {
			var y = game.s2d.width / 2;
			var x = 0;
			var angle = Math.atan2(y - sprite.y, x - sprite.x);
			trace("DOWN: " + x + " " + y + " : " + (angle - 6));
			sprite.rotation = angle - 6;
			
		}
		if (left) {
			var y = 0;
			var x = game.s2d.height / 2;
			var angle = Math.atan2(y - sprite.y, x - sprite.x);
			trace("LEFT: " + x + " " + y + " : " + (angle - 6));
			sprite.rotation = angle - 6;
		}
		
		if (right) {
			var y = game.s2d.width / 2;
			var x = game.s2d.height / 2;
			var angle = Math.atan2(y - sprite.y, x - sprite.x);
			trace("RIGHT: " + x + " " + y + " : " + angle);
			sprite.rotation = angle;
		}
	}
	
	public function update(dt: Float) {
		updateMovement(dt);
		
		sprite.x = Std.int(x);
		sprite.y = Std.int(y);
		
		time += dt * 0.05;
		sprite.y -= (Math.sin(time) + 1) * 3 + 18;
	}
}