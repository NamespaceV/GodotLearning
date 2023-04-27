extends Node2D

var tura: int = 0
var walka: int = 1
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

class Hero:
	var name: String
	var hp: int
	var diceCnt: int
	var diceSize: int
	var r: RandomNumberGenerator
	func isDead() -> bool:
		return hp <= 0
	func write() -> String:
		return name + " [ " + str(hp) + " ]"
	func deadDmg() -> int:
		var dmg = 0
		for i in range(diceCnt):
			dmg += r.randi_range(1,diceSize)
		return dmg
	func takeDmg(d:int):
		hp -= d
	
static func createTank(rng : RandomNumberGenerator) -> Hero: 
	var h:Hero = Hero.new()
	h.r = rng
	h.name = "tank"
	h.hp = 20
	h.diceSize = 20
	h.diceCnt = 1
	return h
	
static func createRanger(rng : RandomNumberGenerator) -> Hero: 
	var h:Hero = Hero.new()
	h.r = rng
	h.name = "ranger"
	h.hp = 10
	h.diceSize = 6
	h.diceCnt = 2
	return h
	
var h1:Hero
var h2:Hero

var textLabel : RichTextLabel

func resetHeroes():
	h1 = createTank(rng)
	h2 = createRanger(rng)

func _ready():
	for child in get_children():
		if child is RichTextLabel:
			textLabel = child
			textLabel.scroll_following = true
	wypisz("Nacisnij WSAD <^v> żeby walczyć")
	resetHeroes()

func wypisz(text: String):
	print(text)
	if textLabel != null:
		textLabel.append_text("\n"+text)

func next_turn():
	if h1.isDead() || h2.isDead():
		resetHeroes()
		walka += 1
		wypisz(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> nowa walka //" + str(walka)+"//")
		tura = 0
	tura += 1
	wypisz(">> tura " + str(tura))
	wypisz(h1.write() +"   vs  "+ h2.write())
	var dmg1 = h1.deadDmg()
	var dmg2 = h2.deadDmg()
	wypisz(h1.name + "        >>      " + str(dmg1) + " dmg")
	wypisz(str(dmg2) + " dmg        <<      " + h2.name )
	h1.takeDmg(dmg2)
	h2.takeDmg(dmg1)
	wypisz("Now: " + h1.write() + "  --  " + h2.write())
	if   h1.isDead() && h2.isDead():
		wypisz(" ========================== REMIS =================== ")
	elif h1.isDead():
		wypisz(" ========================== WYGRAL "+h2.name+" =================== ")
	elif h2.isDead():
		wypisz(" ========================== WYGRAL "+h1.name+" =================== ")

func _process(_delta):
	for i in ["ui_left", "ui_right", "ui_up","ui_down"]:
		if Input.is_action_just_pressed(i):
			next_turn()
	pass
