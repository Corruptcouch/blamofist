package environment;
import h2d.Bitmap;
import h2d.Tile;

/**
 * ...
 * @author Jason Ristich
 */
class Parts 
{
	var game: Game;
	
	var angle : Float = -0.3;
	
	var envParts = [];
	
	public function new(tiles: Array<Tile>) 
	{
		game = Game.inst;
		
		var rnd = new hxd.Rand(42);
		for (i in 0...100) {
			var bMap = new Bitmap(tiles[rnd.random(tiles.length)], game.bg);
			bMap.smooth = true;
			var obj = { sc : 0.7 + rnd.rand(), 
						 x : rnd.rand() * (Game.LW * Game.RATIO + 200) - 100, 
						 y : rnd.rand() * (Game.LH * Game.RATIO + 200) - 100, 
						 speed : rnd.rand() + 1, 
						 spr : bMap, 
						 t : Math.random() * Math.PI * 2 
			};
			envParts.push(obj);
		}
	}
	
	public function update(dt: Float) {
		var currentWay = 1;
		game.way = hxd.Math.lerp(game.way, currentWay, 1 - Math.pow(0.5, dt));
		
		for (c in envParts) {
			var ds = c.speed * dt * 0.3 * game.way;

			c.t += ds * 0.01;
			c.spr.setScale(1 + Math.sin(c.t) * 0.2);
			c.spr.scaleX *= c.sc;

			c.x += Math.cos(angle) * ds;
			c.y += Math.sin(angle) * ds;
			c.spr.x = c.x;
			c.spr.y = c.y;
			if( c.x > Game.LW * 32 + 100 ) {
				c.x -= Game.LW * 32 + 300;
			}
			if( c.y > Game.LH * 32 + 100 ) {
				c.y -= Game.LH * 32 + 300;
			}
			if( c.x < -100 ) {
				c.x += Game.LW * 32 + 300;
			}
			if( c.y < -100 ) {
				c.y += Game.LH * 32 + 300;
			}
		}
	}
}