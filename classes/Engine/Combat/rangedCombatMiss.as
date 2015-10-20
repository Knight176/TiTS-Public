package classes.Engine.Combat 
{
	import classes.Creature;
	/**
	 * ...
	 * @author Gedan
	 */
	public function rangedCombatMiss(attacker:Creature, target:Creature, overrideAttack:Number = -1, missModifier:Number = 1):Boolean 
	{
		if (overrideAttack == -1) overrideAttack = attacker.rangedWeapon.attack;
		
		//Immune!
		if (target.hasPerk("Ranged Immune")) return true;
		
		//Standard miss chance
		if(rand(100) + attacker.aim()/5 + overrideAttack - target.reflexes()/3 < 10 * missModifier && !target.isImmobilized()) 
		{
			return true;
		}
		//Evasion chances
		if(target.evasion() >= rand(100) + 1) 
		{
			trace("RANGED EVASION SUCCESS: " + target.evasion() + "%");
			return true;
		}
		//Take cover chance
		if(target.hasStatusEffect("Taking Cover") && rand(100) + 1 < 90) return true;
		//10% miss chance for lucky breaks!
		if(target.hasPerk("Lucky Breaks") && rand(100) <= 9) return true;
		
		return false;
	}
}