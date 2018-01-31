package entities;
import h2d.Anim;
import h2d.Sprite;
/**
 * ...
 * @author Jason Ristich
 */
class Enemy extends Entity
{	
	var moving : { x : Int, y : Int, dx : Int, dy : Int, k : Float, way : Float };

	public var movingAmount : Float = 0.;
	
	public function new(kind, x : Int, y: Int) 
	{
		super(Enemy, x, y);		
		var spr = new Anim(db.Data.enemies.get(kind), 15);
		game.world.add(spr, Game.LAYER_ENT);	
	}

	
	function updateMove(dt: Float) {
		
	}
	
	public function update(dt:Float) {
		updateMove(dt);
		
		if( moving != null ) {
			var m = moving;
			//dir = hxd.Direction.from(m.dx * m.way, m.dy * m.way);
		}
	}
}