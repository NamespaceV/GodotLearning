extends Object

class_name HeroClasses

enum Spell {
	None,
	Freeze,
	Heal,
}

class Hero:
	var name: String
	var hp: int
	var baseDiceCnt: int
	var diceSize: int
	var spell: Spell
	var r: RandomNumberGenerator
	func isDead() -> bool:
		return hp <= 0
	func write() -> String:
		return name + " [ " + str(hp) + " ]"
	func castBeforeBattle() -> String:
		if (spell == Spell.Heal):
			hp += 2
			return name + " healed 2 damage"
		return ""
	func deadDmg(opponent: Hero) -> int:
		var dmg = 0
		var diceCnt = baseDiceCnt
		if (opponent.spell == Spell.Freeze):
			diceCnt -= 1
		for i in range(diceCnt):
			dmg += r.randi_range(1,diceSize)
		opponent.takeDmg(dmg)
		return dmg
	func takeDmg(d:int):
		hp -= d
	func roundEnd() -> void:
		pass

static func createTank(rng : RandomNumberGenerator) -> HeroClasses.Hero: 
	var h:HeroClasses.Hero = HeroClasses.Hero.new()
	h.r = rng
	h.name = "tank"
	h.hp = 20
	h.diceSize = 20
	h.baseDiceCnt = 1
	return h
	
static func createRanger(rng : RandomNumberGenerator) -> HeroClasses.Hero: 
	var h:HeroClasses.Hero = HeroClasses.Hero.new()
	h.r = rng
	h.name = "ranger"
	h.hp = 10
	h.diceSize = 6
	h.baseDiceCnt = 2
	return h

static func createFrostMage(rng : RandomNumberGenerator) -> HeroClasses.Hero: 
	var h:HeroClasses.Hero = HeroClasses.Hero.new()
	h.r = rng
	h.name = "frost mage"
	h.hp = 6
	h.diceSize = 4
	h.baseDiceCnt = 1
	h.spell = Spell.Freeze
	return h

static func createCleric(rng : RandomNumberGenerator) -> HeroClasses.Hero: 
	var h:HeroClasses.Hero = HeroClasses.Hero.new()
	h.r = rng
	h.name = "cleric"
	h.hp = 6
	h.diceSize = 4
	h.baseDiceCnt = 1
	h.spell = Spell.Heal
	return h


