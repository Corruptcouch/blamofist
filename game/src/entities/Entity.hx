package entities;
import h2d.Anim;
import h2d.Tile;
import hxd.Res;

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
		enemyTile = Res.enemies.enemyShip.toTile();
		game = Game.inst;
		this.x = x + 0.5;
		this.y = y + 0.5;
		spr = new Anim([enemyTile, enemyTile], 15);
		game.world.add(spr, Game.LAYER_ENT);
		game.entities.push(this);
	}
	
	public function remove() {
		spr.remove();
		game.entities.remove(this);
	}
}