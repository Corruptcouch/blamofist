package entities;
import cdb.Data;
import h2d.Graphics;
import hxd.Key;
import hxd.Res;

/**
 * ...
 * @author Jason Ristich
 */
class Player extends Entity
{
	var inf : db.Data.Player;
	
	var acc = 0.;
	var dir(default, set) : hxd.Direction;

	public var lives: Array<Int> = [];
	public var inventory : Array<Entity> = [];
	var moving : { x : Int, y : Int, dx : Int, dy : Int, k : Float, way : Float };

	public var movingAmount : Float = 0.;
	
	var tag: Graphics;
	var padActive : Bool;
	
	public function new(x, y) 
	{
		super(x, y);
		game.world.add(spr, Game.LAYER_HERO);
		tag = new Graphics();
		game.world.add(tag, Game.LAYER_ENT + 1);
		tag.x = -1000;
		tag.lineStyle(1, 0xFF0000);
		tag.drawRect(0, 0, 32, 32);
	}
	
	function getAnim() {
		switch(dir) {
		case Left:
			return [Res.playerLeft.toTile()];
		case Right:
			return [Res.playerRight.toTile()];
		default:
		}
		return [Res.player.toTile()];
	}
	
	function set_dir(d) {
		if( dir != d ) {
			dir = d;
			spr.play(getAnim(), spr.currentFrame);
		}
		return d;
	}
	
	function updateMove(dt:Float) {
		if( acc > 5 ) acc = 5;
		var dacc = dt * 0.1;
		var dmove = dt * 0.01 * (acc + 7);
		var fric = Math.pow(0.8, dt);
		
		var left = Key.isDown(Key.LEFT) || game.gamePad.xAxis < -0.5;
		var right = Key.isDown(Key.RIGHT) || game.gamePad.xAxis > 0.5;
		var up = Key.isDown(Key.UP) || game.gamePad.yAxis < -0.5;
		var down = Key.isDown(Key.DOWN) || game.gamePad.yAxis > 0.5;
		
		if( game.gamePad.xAxis != 0 || game.gamePad.yAxis != 0 ) {
			var k = Math.sqrt(game.gamePad.xAxis * game.gamePad.xAxis + game.gamePad.yAxis * game.gamePad.yAxis);
			if( k > 0.5 ) padActive = true;
			if( padActive ) {
				if( k < 0.5 ) k = 0.5;
				dmove *= k;
			}
		}
		
		if( moving != null ) {
			if( moving.dx < 0 ) {
				if( right )
					moving.way = -1;
				else if( left )
					moving.way = 1;
			} else if( moving.dx > 0 ) {
				if( right )
					moving.way = 1;
				else if( left )
					moving.way = -1;
			}
			if( moving.dy < 0 ) {
				if( up )
					moving.way = 1;
				else if( down )
					moving.way = -1;
			} else if( moving.dy > 0 ) {
				if( up )
					moving.way = -1;
				else if( down )
					moving.way = 1;
			}
		}	
		if( moving != null ) {
			var prev = moving.k;

			movingAmount = dmove * moving.way;

			moving.k += dmove * moving.way;
			var end = false;
			if( moving.k >= 1 ) {
				moving.k = 1;
				end = true;
			} else if( moving.k <= 0 ) {
				moving.k = 0;
				end = true;
			}
			x = moving.x + moving.dx * moving.k + 0.5;
			y = moving.y + moving.dy * moving.k + 0.5;
			if( dmove > 0 )
				acc += dacc;
			else
				acc *= fric;
			
			if (end) {
				var ix = Std.int(x), iy = Std.int(y);
			}
			if (end) {
				moving = null;
			} else {
				movingAmount = 0;
			}
		}
	}
	
	override function update(dt:Float) {
		updateMove(dt);
		
		super.update(dt);
		
		if( moving != null ) {
			var m = moving;
			dir = hxd.Direction.from(m.dx * m.way, m.dy * m.way);
		}
	}
}