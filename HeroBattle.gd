extends Node2D

var tura: int = 0
var walka: int = 1
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var h1:HeroClasses.Hero
var h2:HeroClasses.Hero

@onready var textLabel : RichTextLabel = $MainText as RichTextLabel

func resetHeroes():
	h1 = HeroClasses.createTank(rng)
	h2 = HeroClasses.createRanger(rng)

func _ready():
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
	var dmg1 = h1.deadDmg(h2)
	var dmg2 = h2.deadDmg(h1)
	wypisz(h1.name + "        >>      " + str(dmg1) + " dmg")
	wypisz(str(dmg2) + " dmg        <<      " + h2.name )
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
