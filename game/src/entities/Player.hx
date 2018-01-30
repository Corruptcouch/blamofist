package entities;
import cdb.Data;
import h2d.Anim;
import h2d.Bitmap;
import h2d.Graphics;
import h2d.TileGroup;
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
	
	var colX = -1;
	var colY = -1;
	var colTile : h2d.Tile;
	var colView : h2d.TileGroup;
	var colPlayer : Bitmap;
	
	var padActive : Bool;
	
	public function new(x, y) 
	{
		super(Player, x, y);
		colX = Std.int(this.x * 8);
		colY = Std.int(this.y * 8);
		colTile = Res.player.toTile();
		colView = new TileGroup(colTile);
		
		var m = h3d.Matrix.I();
		m._44 = 0.15;
		colView.blendMode = Add;
		colView.addShader(new h3d.shader.SinusDeform(20,0.005,3));
		colView.filter = new h2d.filter.ColorMatrix(m);
		
		colPlayer = new h2d.Bitmap(colTile, colView);
		spr.scale(0.25);
		
		game.world.add(colView, Game.LAYER_COL);
		game.world.add(spr, Game.LAYER_HERO);
	}
	
	override function getAnim() {
		var playerTile = Res.player.toTile();
		var playerLeftTile = Res.playerLeft.toTile();
		var playerRightTile = Res.playerRight.toTile();
		
		switch(dir) {
		case Left:
			trace("animation left");
			return [playerTile, playerLeftTile];
		case Right:
			trace("animation right");
			return [playerTile, playerRightTile];
		default:
		}
		trace("default");
		return [playerTile, playerTile];
	}
	
	function set_dir(d) {
		if( dir != d ) {
			dir = d;
			var anim = getAnim();
			spr.play(anim, spr.currentFrame);
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
		
		// cancel
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
		if ( moving != null ) {
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
			
			if( dmove > 0 ) {
				acc += dacc;
			}
			else {
				acc *= fric;
			}
		
			if (end) {
				moving = null;
			} 
		} 
		else {
			movingAmount = 0;
		}
		
		if( moving == null ) {
			var updateLR = null;
			var updateUD = null;

			if( left || right ) {
				//var nextY = Std.int(y);
				//var nextX = Std.int(x) + (left ? -1 : 1);
				//if( !game.isCollide(this, nextX, nextY) )
					updateLR = function() moving = { x : Std.int(x), y : Std.int(y), k : 0, way : 1, dx : left ? -1 : 1, dy : 0 };
			}

			if( up || down ) {
				//var nextX = Std.int(x);
				//var nextY = Std.int(y) + (up ? -1 : 1);
				//if( !game.isCollide(this, nextX, nextY) )
					updateUD = function() moving = { x : Std.int(x), y : Std.int(y), k : 0, way : 1, dy : up ? -1 : 1, dx : 0 };
			}

			if( updateLR != null && updateUD != null ) {
				if( Math.abs(game.gamePad.xAxis) > Math.abs(game.gamePad.yAxis) )
					updateUD = null;
				else
					updateLR = null;
			}

			if( updateLR != null )
				updateLR();
			else if( updateUD != null )
				updateUD();
			else
				acc *= fric * fric;

		}
	}
	
	public override function update(dt:Float) {
		updateMove(dt);
		super.update(dt);
		
		if( moving != null ) {
			var m = moving;
			dir = hxd.Direction.from(m.dx * m.way, m.dy * m.way);
		}
	}
}