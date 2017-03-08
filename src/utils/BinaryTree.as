package utils {
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class BinaryTree {
		
		static public var heap:Vector.<BinaryTree> = new Vector.<BinaryTree>();
		
		public var left:BinaryTree;
		public var right:BinaryTree;
		public var node:FlxSprite;
		
		public function BinaryTree(root:FlxSprite) {
			left = null;
			right = null;
			node = root;
		}
		public function destroy():void {
			if (left)
				left.destroy();
			left = null;
			if (right)
				right.destroy();
			right = null;
			node = null;
			
			heap.push(this);
		}
		
		public function insert(spr:FlxSprite):void {
			if (spr.y > node.y)
				if (right)
					right.insert(spr);
				else if (heap.length > 0) {
					right = heap.pop();
					right.node = spr;
				}
				else
					right = new BinaryTree(spr);
			else
				if (left)
					left.insert(spr);
				else if (heap.length > 0) {
					left = heap.pop();
					left.node = spr;
				}
				else
					left = new BinaryTree(spr);
		}
		
		public function draw():void {
			if (left)
				left.draw();
			node.draw();
			if (right)
				right.draw();
		}
	}
}
