package entities;
import h2d.Graphics;

/**
 * ...
 * @author Jason Ristich
 */
class Enemy extends Entity
{
	var inf : db.Data.Enemies;
	var kind : db.Data.EnemiesKind;

	var acc = 0.;
	var dir(default, set) : hxd.Direction;
	
	public var inventory : Array<Entity> = [];
	var moving : { x : Int, y : Int, dx : Int, dy : Int, k : Float, way : Float };

	public var movingAmount : Float = 0.;
	
	var tag: Graphics;
	
	public function new(x, y) 
	{
		super(x, y);
		game.world.add(spr, Game.LAYER_ENT);
		game.enemies.push(this);
		tag = new Graphics();
		game.world.add(tag, Game.LAYER_ENT + 1);
		tag.x = -1000;
		tag.lineStyle(1, 0xFF0000);
		tag.drawRect(0, 0, 32, 32);		
	}
	
	function getAnim() {
		return [];
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
	
	override function remove() {
		game.enemies.remove(this);
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