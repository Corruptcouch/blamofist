package;
import h2d.Bitmap;
import h2d.Text;
import hxd.Res;
import hxd.res.DefaultFont;

/**
 * ...
 * @author Jason Ristich
 */
class Title 
{
	var game: Game;
	var image: Bitmap;
	
	public function new() 
	{
		game = Game.inst;
		image = new Bitmap(Res.background.red.toTile(), game.world);
		image.scale(2);
		addText();
	}
	
	function addText() {
		var text = new Text(DefaultFont.get(), image);
		text.scale(0.5);
		text.textColor = 0xFFFFFF;
		text.text = "Press space / A to start";
		text.x = ((Game.LW * Game.RATIO) - (text.textWidth * 2)) >> 1;
		text.y = 180;
	}
	
	public function getAlpha() {
		return image.alpha;
	}
	
	public function setAlpha(alpha: Float) {
		image.alpha = alpha;
	}
	
	public function remove() {
		image.remove();
	}
}