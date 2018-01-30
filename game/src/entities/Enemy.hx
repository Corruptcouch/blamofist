package entities;
import h2d.Anim;
import h2d.Graphics;
import hxd.Res;

/**
 * ...
 * @author Jason Ristich
 */
class Enemy extends Entity
{
	var inf : db.Data.Enemies;
	var acc = 0.;
	var dir(default, set) : hxd.Direction;
	
	var moving : { x : Int, y : Int, dx : Int, dy : Int, k : Float, way : Float };

	public var movingAmount : Float = 0.;
	
	public function new(x : Int, y: Int) 
	{
		super(Enemy, x, y);		
		spr = new Anim(getAnim(), 15);
		game.world.add(spr, Game.LAYER_ENT);	
	}
	
	override function getAnim() {
		return [Res.enemies.enemyShip.toTile()];
	}
	
	function set_dir(d) {
		if( dir != d ) {
			dir = d;
			spr.play(getAnim(), spr.currentFrame);
		}
		return d;
	}
	
	function updateMove(dt: Float) {
		
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