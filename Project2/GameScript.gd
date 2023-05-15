extends Node

@export var textLabel : RichTextLabel

@export var enemies: Array[Being]
@export var summons: Array[Being]

var inputs: Array[String] = [ "ui_up", "ui_right", "ui_down", "ui_left"]
var input_names: Array[String] = ["up   ", "right", "down ", "left "  ]

var enemy: Being = null
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _process(_delta):
	for i in inputs:
		if Input.is_action_just_pressed(i):
			next_turn(i)
	pass

func _ready():
	rollNewEnemy()
	next_turn()

func rollNewEnemy():
	enemy = enemies[rng.randi_range(0, enemies.size()-1)]

func wypisz(text: String):
	print(text)
	if textLabel != null:
		textLabel.append_text("\n"+text)

func wypiszSummony():
	var i = 0
	for s in summons:
		wypisz("    [ " + input_names[i] + " ] ->  " + s.name)
		i += 1

func next_turn(input:String = ""):
	if enemy == null:
		rollNewEnemy()
		input = ""
	
	if input == "":
		wypisz("")
		wypisz("")
		wypisz("🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬")
		wypisz(" ================== wild " + enemy.name + " appears")
		wypisz("🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬")
		wypisz("choose your weapon ")
		wypiszSummony()
		return

	var inputId = inputs.find(input)
	if not (inputId >= 0 && inputId < summons.size()):
		wypisz("chosen: nothing")
		wypisz("wild " + enemy.name + " is stil there")
		wypisz("choose wisely")
		wypiszSummony()
		return

	var summon = summons[inputId]
	wypisz("chosen summon: " + summon.name)
	if summon.strength > enemy.strength:
		wypisz("☠☠☠☠☠☠☠☠☠☠☠☠☠☠")
		wypisz("*** DEFEATED enemy : " + enemy.name)
		wypisz("☠☠☠☠☠☠☠☠☠☠☠☠☠☠")
		wypisz("get ready for next battle (any dir)")
		enemy = null
	else:
		wypisz("😱😱😱😱😱😱😱😱😱😱😱😱😱😱😱")
		wypisz("enemy : " + enemy.name + " Is too strong")
		wypisz("😱😱😱😱😱😱😱😱😱😱😱😱😱😱😱")
		wypisz("choose a different summon")
		wypiszSummony()
	
