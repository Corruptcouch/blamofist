import h2d.Anim;
import h2d.Bitmap;
import h2d.Sprite;
import h2d.Text;
import h2d.Tile;
import hxd.Res;
import hxd.res.Font;

class Main extends hxd.App {
        
		var animation:Anim;

		// Called on creation
        override function init() {
			animation = new Anim(jump(), 10, s2d);
        }


		static function shoot() {
			var shootTiles = new Array<Tile>();
			for(resource in Res.Shoot) {
				shootTiles.push(resource.toTile());
			}
			return shootTiles;
		}

		static function slide() {
			var slideTiles = new Array<Tile>();
			for(resource in Res.Slide) {
				slideTiles.push(resource.toTile());
			}
			return slideTiles;
		}

		static function jump() {
			var jumpTiles = new Array<Tile>();
			for(resource in Res.Jump) {
				jumpTiles.push(resource.toTile());
			}
			return jumpTiles;
		}

		static function run() {
			var runTiles = new Array<Tile>();
			for(resource in Res.Run) {
				runTiles.push(resource.ToTile());
			}
			return runTiles;
		}

        static function main() {

			Res.initEmbed();
            new Main();
        }
    }