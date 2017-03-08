package enemiesPkg.boss01 {
	
	import basics.BossWeapon;
	import enShooters.bossShooters.bsShLaser;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Boss01Laser extends BossWeapon {
		
		public function Boss01Laser() {
			super(55, 49);
			Resources.bossLaser(this);
			shooter = new bsShLaser();
			shooter.setParent(this);
			health = 30;
		}
	}
}
