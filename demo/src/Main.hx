import h2d.Anim;
import h2d.Bitmap;
import h2d.Interactive;
import h2d.Sprite;
import h2d.Text;
import h2d.Tile;
import hxd.Key;
import hxd.Res;
import hxd.res.Font;

class Main extends hxd.App {
        
		var idleAnimation:Anim;
		var runRightAnimation:Anim;
		var runLeftAnimation:Anim;
		var jumpAnimation:Anim;
		var slideLeftAnimation:Anim;
		var slideRightAnimation:Anim;

		// Called on creation
        override function init() {
			Res.initEmbed();
			
			idleAnimation = new Anim(idle(), s2d);
			runRightAnimation = new Anim(runRight(), s2d);
			runRightAnimation.visible = false;
			runLeftAnimation = new Anim(runLeft(), s2d);
			runLeftAnimation.visible = false;
			jumpAnimation = new Anim(jump(), s2d);
			jumpAnimation.visible = false;
			slideLeftAnimation = new Anim(slideLeft(), s2d);
			slideLeftAnimation.visible = false;
			slideRightAnimation = new Anim(slideRight(), s2d);
			slideRightAnimation.visible = false;
        }


		static function idle() {
			var idleTiles = new Array<Tile>();
			idleTiles.push(Res.character.Idle.Idle1.toTile());
			idleTiles.push(Res.character.Idle.Idle2.toTile());
			idleTiles.push(Res.character.Idle.Idle3.toTile());
			idleTiles.push(Res.character.Idle.Idle4.toTile());
			idleTiles.push(Res.character.Idle.Idle5.toTile());
			idleTiles.push(Res.character.Idle.Idle6.toTile());
			idleTiles.push(Res.character.Idle.Idle7.toTile());
			idleTiles.push(Res.character.Idle.Idle8.toTile());
			idleTiles.push(Res.character.Idle.Idle9.toTile());
			idleTiles.push(Res.character.Idle.Idle10.toTile());
			return idleTiles;
		}
		static function shoot() {
			var shootTiles = new Array<Tile>();
			shootTiles.push(Res.character.Shoot.Shoot1.toTile());
			shootTiles.push(Res.character.Shoot.Shoot2.toTile());
			shootTiles.push(Res.character.Shoot.Shoot3.toTile());
			return shootTiles;
		}

		static function slideRight() {
			var slideTiles = new Array<Tile>();
			slideTiles.push(Res.character.Slide.Slide1.toTile());
			slideTiles.push(Res.character.Slide.Slide2.toTile());
			slideTiles.push(Res.character.Slide.Slide3.toTile());
			slideTiles.push(Res.character.Slide.Slide4.toTile());
			slideTiles.push(Res.character.Slide.Slide5.toTile());
			return slideTiles;
		}
		
		static function slideLeft() {
			var slideTiles = new Array<Tile>();
			slideTiles.push(Res.character.Slide.Slide1.toTile());
			slideTiles.push(Res.character.Slide.Slide2.toTile());
			slideTiles.push(Res.character.Slide.Slide3.toTile());
			slideTiles.push(Res.character.Slide.Slide4.toTile());
			slideTiles.push(Res.character.Slide.Slide5.toTile());
			for (tile in slideTiles) {
				tile.flipY;
			}
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

		static function runRight() {
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
		
		static function runLeft() {
			var runTiles = new Array<Tile>();
			runTiles.push(Res.character.Run.Run1.toTile());
			runTiles.push(Res.character.Run.Run2.toTile());
			runTiles.push(Res.character.Run.Run3.toTile());
			runTiles.push(Res.character.Run.Run4.toTile());
			runTiles.push(Res.character.Run.Run5.toTile());
			runTiles.push(Res.character.Run.Run6.toTile());
			runTiles.push(Res.character.Run.Run7.toTile());
			for (tile in runTiles) {
				tile.flipY;
			}
			return runTiles;
		}

		override function update(dt:Float) 
		{
			if (Key.isReleased(Key.LEFT) || Key.isReleased(Key.RIGHT) || Key.isReleased(Key.UP) || Key.isReleased(Key.LSHIFT) || Key.isReleased(Key.RSHIFT)) {
				runLeftAnimation.visible = false;
				runRightAnimation.visible = false;
				jumpAnimation.visible = false;
				slideLeftAnimation.visible = false;
				slideRightAnimation.visible = false;
				idleAnimation.visible = true;
			}
			if (Key.isPressed(Key.LEFT) || Key.isDown(Key.LEFT)) {
				idleAnimation.visible = false;
				runLeftAnimation.visible = true;
			}
			
			if (Key.isPressed(Key.UP)) {
				idleAnimation.visible = false;
				jumpAnimation.visible = true;
			}
			if (Key.isPressed(Key.RIGHT) || Key.isDown(Key.RIGHT)) {
				idleAnimation.visible = false;
				runRightAnimation.visible = true;
			}
			if (Key.isPressed(Key.LSHIFT)) {
				idleAnimation.visible = false;
				slideLeftAnimation.visible = true;
			}
			if (Key.isPressed(Key.RSHIFT)) {
				idleAnimation.visible = false;
				slideRightAnimation.visible = true;
			}
			super.update(dt);
		}
		
        static function main() {
            new Main();
        }
    }