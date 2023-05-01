extends Node2D

var tura: int = 0
var walka: int = 1
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var h1:HeroClasses.Hero
var h2:HeroClasses.Hero

@onready var textLabel : RichTextLabel = $MainText as RichTextLabel

@onready var leftNameLabel : RichTextLabel = $Left/Name as RichTextLabel
@onready var leftHpLabel : RichTextLabel = $Left/Hp as RichTextLabel
@onready var leftImage : Sprite2D = $Left/Image as Sprite2D

@onready var rightHpLabel : RichTextLabel = $Right/Hp as RichTextLabel
@onready var rightNameLabel : RichTextLabel = $Right/Name as RichTextLabel
@onready var rightImage : Sprite2D = $Right/Image as Sprite2D

func getTexture(n:String):
#	assets source:
#	https://opengameart.org/content/cute-cleric
#	https://opengameart.org/content/soulless-mage
#	https://opengameart.org/content/cute-warrior

	match n:
		"frost mage":
			return preload("res://Assets/mage.png")
		"cleric":
			return preload("res://Assets/priest.png")
		_:
			return preload("res://Assets/Warrior.png")

func resetHeroes():
	h1 = HeroClasses.createRandom(rng)
	h2 = HeroClasses.createRandom(rng)
	leftNameLabel.text = h1.name
	leftImage.texture = getTexture(h1.name)
	rightNameLabel.text = h2.name
	rightImage.texture = getTexture(h2.name)
	leftHpLabel.text  = "DEAD" if h1.isDead() else str(h1.hp);
	rightHpLabel.text = "DEAD" if h2.isDead() else str(h2.hp);

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
	var before = h1.castBeforeBattle();
	if before != "":
		wypisz(before);
	before = h2.castBeforeBattle();
	if before != "":
		wypisz(before);
	
	var dmg1 = h1.deadDmg(h2)
	var dmg2 = h2.deadDmg(h1)
	h1.roundEnd();
	h2.roundEnd();
	leftHpLabel.text  = "DEAD" if h1.isDead() else str(h1.hp);
	rightHpLabel.text = "DEAD" if h2.isDead() else str(h2.hp);
	
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
