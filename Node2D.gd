extends Node2D

var tura: int = 0
var walka: int = 1

var name1: String = "tank"
var hp1:int = 20
var dice1d:int = 20
var dice1cnt:int = 1

var name2: String = "ranger"
var hp2:int = 10
var dice2d:int = 6
var dice2cnt:int = 2

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var textLabel : RichTextLabel

func reset():
	name1 = "tank"
	hp1 = 20
	dice1d = 20
	dice1cnt = 1
	name2 = "ranger"
	hp2 = 10
	dice2d = 6
	dice2cnt = 2


func _ready():
	for child in get_children():
		if child is RichTextLabel:
			textLabel = child
			textLabel.scroll_following = true
	wypisz("Nacisnij WSAD <^v> żeby walczyć")
	reset()
	

func wypisz(text: String):
	print(text)
	textLabel.append_text("\n"+text)

func next_turn():
	if hp1 < 0 || hp2 < 0:
		reset()
		walka += 1
		wypisz(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> nowa walka //" + str(walka)+"//")
		tura = 0
	tura += 1
	wypisz(">> tura " + str(tura))
	wypisz(name1 + " ["+ str(hp1) + "]"+"   vs  "+ name2+ " ["+str(hp2)+"]")
	var dmg1 = 0
	for i in range(dice1cnt):
		dmg1 += rng.randi_range(1,dice1d)
	var dmg2 = 0
	for i in range(dice2cnt):
		dmg2 += rng.randi_range(1,dice2d)
	wypisz(name1+" zadal "+ str(dmg1)+" obrazen")
	wypisz(name2+" zadal "+ str(dmg2)+" obrazen")
	hp2 -= dmg1
	hp1 -= dmg2
	wypisz("Now: "+name1+"["+str(hp1)+"]"+"  --  "+ name2+ "["+str(hp2)+"]")
	if  hp1 < 0 && hp2 < 0:
		wypisz(" ========================== REMIS =================== ")
	elif hp1 < 0:
		wypisz(" ========================== WYGRAL "+name2+" =================== ")
	elif hp2 < 0:
		wypisz(" ========================== WYGRAL "+name1+" =================== ")

func _process(_delta):
	for i in ["ui_left", "ui_right", "ui_up","ui_down"]:
		if Input.is_action_just_pressed(i):
			next_turn()
	pass
