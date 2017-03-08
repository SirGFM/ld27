package players {
	
	import basics.Player;
	import collectibles.SwitchWeapon;
	import plShooters.PlSpike;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class SK_DMG extends Player {
		
		public function SK_DMG() {
			super(SwitchWeapon.SPIKE);
			Resources.plSpikeyGFX(this);
			
			center.make(11.5, 12.5);
			radius = 1.75;
		}
	}
}
