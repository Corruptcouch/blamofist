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
			Res.initEmbed();
			animation = new Anim(run(), 10, s2d);
        }


		static function shoot() {
			var shootTiles = new Array<Tile>();
			shootTiles.push(Res.character.Shoot.Shoot1.toTile());
			shootTiles.push(Res.character.Shoot.Shoot2.toTile());
			shootTiles.push(Res.character.Shoot.Shoot3.toTile());
			return shootTiles;
		}

		static function slide() {
			var slideTiles = new Array<Tile>();
			slideTiles.push(Res.character.Slide.Slide1.toTile());
			slideTiles.push(Res.character.Slide.Slide2.toTile());
			slideTiles.push(Res.character.Slide.Slide3.toTile());
			slideTiles.push(Res.character.Slide.Slide4.toTile());
			slideTiles.push(Res.character.Slide.Slide5.toTile());
			return slideTiles;
		}

		static function jump() {
			var jumpTiles = new Array<Tile>();
			jumpTiles.push(Res.character.Jump.Jump1.toTile());
			jumpTiles.push(Res.character.Jump.Jump2.toTile());
			jumpTiles.push(Res.character.Jump.Jump3.toTile());
			jumpTiles.push(Res.character.Jump.Jump4.toTile());
			jumpTiles.push(Res.character.Jump.Jump5.toTile());
			jumpTiles.push(Res.character.Jump.Jump6.toTile());
			jumpTiles.push(Res.character.Jump.Jump7.toTile());
			jumpTiles.push(Res.character.Jump.Jump8.toTile());
			jumpTiles.push(Res.character.Jump.Jump9.toTile());
			jumpTiles.push(Res.character.Jump.Jump10.toTile());
			return jumpTiles;
		}

		static function run() {
			var runTiles = new Array<Tile>();
			runTiles.push(Res.character.Run.Run1.toTile());
			runTiles.push(Res.character.Run.Run2.toTile());
			runTiles.push(Res.character.Run.Run3.toTile());
			runTiles.push(Res.character.Run.Run4.toTile());
			runTiles.push(Res.character.Run.Run5.toTile());
			runTiles.push(Res.character.Run.Run6.toTile());
			runTiles.push(Res.character.Run.Run7.toTile());
			return runTiles;
		}

        static function main() {
            new Main();
        }
    }