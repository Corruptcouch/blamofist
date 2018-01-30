package entities;
import h2d.Anim;
import hxd.Res;

/**
 * ...
 * @author Jason Ristich
 */
class Entity 
{
	var game : Game;
	public var x : Float;
	public var y : Float;
	public var spr : Anim;
	
	var kind: Any;
	
	public function new(kind, x : Int, y: Int) 
	{
		this.kind = kind;
		game = Game.inst;
		this.x = x + 0.5;
		this.y = y + 0.5;
		spr = new Anim(getAnim(), 15);
		game.world.add(spr, Game.LAYER_ENT);
		game.entities.push(this);
	}
	
	function getAnim() {
		return [Res.player.toTile()];
	}
	public function remove() {
		spr.remove();
		game.entities.remove(this);
	}	
	
	public function update(dt: Float) {
		spr.x = Std.int(x * 64) / 2;
		spr.y = Std.int(y * 64) / 2;
		trace(this.toString()); 
	}
	
	function toString() {
		return kind + "(" + Std.int(x) + "," + Std.int(y) + ")";
	}
}