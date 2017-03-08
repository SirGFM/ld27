package utils {
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class ZDrawer extends FlxGroup {
		
		override public function draw():void {
			var root:BinaryTree;
			var i:int = 0;
			while (i < length) {
				var spr:FlxSprite = members[i++] as FlxSprite;
				if (!(spr && spr.exists && spr.visible))
					continue;
				if (root)
					root.insert(spr);
				else if (BinaryTree.heap.length > 0) {
					root = BinaryTree.heap.pop();
					root.node = spr;
				}
				else
					root = new BinaryTree(spr);
			}
			if (root) {
				root.draw();
				root.destroy();
			}
		}
	}
}
