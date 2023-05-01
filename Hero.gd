extends Object

class_name HeroClasses

class Hero:
	var name: String
	var hp: int
	var baseDiceCnt: int
	var diceSize: int
	var isMage: bool
	var r: RandomNumberGenerator
	func isDead() -> bool:
		return hp <= 0
	func write() -> String:
		return name + " [ " + str(hp) + " ]"
	func deadDmg(opponent: Hero) -> int:
		var dmg = 0
		var diceCnt = baseDiceCnt
		if (opponent.isMage):
			diceCnt -= 1
		for i in range(diceCnt):
			dmg += r.randi_range(1,diceSize)
		opponent.takeDmg(dmg)
		return dmg
	func takeDmg(d:int):
		hp -= d

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

static func createMage(rng : RandomNumberGenerator) -> HeroClasses.Hero: 
	var h:HeroClasses.Hero = HeroClasses.Hero.new()
	h.r = rng
	h.name = "mage"
	h.hp = 6
	h.diceSize = 4
	h.baseDiceCnt = 1
	h.isMage = true
	return h


