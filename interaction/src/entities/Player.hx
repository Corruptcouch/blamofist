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
		this.x = x + 0.5;
		this.y = y + 0.5;
		sprite = new h2d.Bitmap(Res.player.idle.toTile());
		sprite.scale(0.25);
		sprite.tile.dx = -50;
		sprite.tile.dy = -50;
		game.world.add(sprite, Game.LAYER_PLAYER);
	}
	
	public var padActive = false;
	
	var rotationSpeed = Math.PI / 50;
	
	function calculateRadiansFromFacingInt(facingInt : Float) {
		facingInt = Math.abs(facingInt);
		var degrees = (facingInt % 6.0) * 360;
		trace("DEGREES: " + degrees);
		return degrees;
	}
	
	function updateMovement(dt:Float) {
		var left = Key.isDown(Key.LEFT) || game.gamePad.xAxis < -0.5;
		var right = Key.isDown(Key.RIGHT) || game.gamePad.xAxis > 0.5;
		var up = Key.isDown(Key.UP) || game.gamePad.yAxis < -0.5;
		var down = Key.isDown(Key.DOWN) || game.gamePad.yAxis > 0.5;
		
		if (up) {
			var degrees = calculateRadiansFromFacingInt(sprite.rotation);
			if (degrees >= 0 && degrees <= 180) {
				sprite.rotation -= rotationSpeed;
			}
			if (degrees >= 180 && degrees <= 360) {
				sprite.rotation += rotationSpeed;
			}
		}
		
		if (down) {
			var degrees = calculateRadiansFromFacingInt(sprite.rotation);
			if (degrees >= 0 && degrees <= 180) {
				sprite.rotation += rotationSpeed;
			}
			if (degrees >= 180 && degrees <= 360) {
				sprite.rotation -= rotationSpeed;
			}
		}
		if (left) {
			var degrees = calculateRadiansFromFacingInt(sprite.rotation);
			if (degrees >= 270 && degrees <= 90) {
				sprite.rotation -= rotationSpeed;
			}
			if (degrees <= 270 && degrees >= 90) {
				sprite.rotation += rotationSpeed;
			}
		}
		
		if (right) {
			var degrees = calculateRadiansFromFacingInt(sprite.rotation);
			if (degrees >= 270 && degrees <= 90) {
				sprite.rotation += rotationSpeed;
			}
			if (degrees <= 270 && degrees >= 90) {
				sprite.rotation -= rotationSpeed;
			}
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