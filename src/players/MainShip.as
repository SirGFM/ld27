package players {
	
	import basics.Player;
	import collectibles.SwitchWeapon;
	import plShooters.PlShootgun;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class MainShip extends Player {
		
		public function MainShip() {
			super(SwitchWeapon.SHOOTGUN);
			Resources.playerGFX(this);
			
			center.make(11.5, 13.5);
			radius = 0.75;
		}
		
		override protected function special():void {
			invunerable = 10;
		}
	}
}
