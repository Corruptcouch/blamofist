package entities;

/**
 * ...
 * @author Jason Ristich
 */
class Entity 
{
	var game : Game;
	public var x : Float;
	public var y : Float;
	
	public function new(kind, x : Int, y: Int) 
	{
		game = Game.inst;
		this.x = x + 0.5;
		this.y = y + 0.5;
		game.entities.push(this);
	}
	public function remove() {
		game.entities.remove(this);
	}
}