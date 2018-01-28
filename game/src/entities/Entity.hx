package entities;
import h2d.Anim;
import h2d.Tile;

/**
 * ...
 * @author Jason Ristich
 */
class Entity 
{
	var enemyTile: Tile;
	var game : Game;
	public var x : Float;
	public var y : Float;
	public var spr : Anim;
	
	public function new(x : Int, y: Int) 
	{
		game = Game.inst;
		this.x = x + 0.5;
		this.y = y + 0.5;
		spr = new Anim([enemyTile, enemyTile], 15);
		game.world.add(spr, Game.LAYER_ENT);
	}
	
	public function remove() {
		spr.remove();
	}
	
	
	function update(dt: Float) {
		spr.x = Std.int(x * 64) / 2;
		spr.y = Std.int(y * 64) / 2;
	}
}