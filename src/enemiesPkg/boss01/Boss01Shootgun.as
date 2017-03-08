package enemiesPkg.boss01 {
	
	import basics.BossWeapon;
	import enShooters.bossShooters.bsShShootgun;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Boss01Shootgun extends BossWeapon {
		
		public function Boss01Shootgun() {
			super(56, 30);
			shooter = new bsShShootgun();
			shooter.setParent(this);
			health = 30;
			Resources.bossShootgun(this);
		}
	}
}
