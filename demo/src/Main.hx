import h2d.Text;
import hxd.Res;

class Main extends hxd.App {
        var text : Text;

		// Called on creation
        override function init() {
			// Initialize all loaders for embeded resources
			Res.initEmbed();
			// Create an instance of wireframe.tff located in our res folder, then create a font2d of 128pt size
			var font = Res.firacode.build(128);
			// Create a new text object using the newly created font, parented to the 2d scene
            text = new Text(font, s2d);
			// Assign the text
			text.text = "Hello World";
			// Make it read, using hex code ( RR GG BB, each two hex characters represent an RGB value from 0 - 255 )
			text.textColor = 0xFF0000;
        }

		// Called each frame
        override function update(dt:Float) {
			// simply scale our text object up until it's 3x normal size, repeat forever
			var scaleAmount = 0.01;
			if (text.scaleX < 3.0) text.setScale(text.scaleX + scaleAmount);
			else text.setScale(1);
			
        }

        static function main() {
            new Main();
        }
    }