extends Node

@export var textLabel : RichTextLabel
@export var uciekajButton : Button
@export var zostanButton : Button

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var Up  : bool = false
var Down  : bool = false

@export var rooms : Array[DungeonRoom]

var room: DungeonRoom

var choices = ["Zbieraj zasoby", "Uciekaj"]

var yourChoiceId = 0

const TurnTime = 5.0
var TurnTimeLeft : float = TurnTime

func _ready():
	nowaLokacja()
	uciekajButton.pressed.connect(pressedUciekaj)
	zostanButton.pressed.connect(pressedZostan)

func pressedUciekaj():
	yourChoiceId = 1

func pressedZostan():
	yourChoiceId = 0

func _process(_delta):
	Up = Input.is_action_just_pressed("ui_up")
	Down = Input.is_action_just_pressed("ui_down")
	
	TurnTimeLeft -= _delta
	while TurnTimeLeft < 0:
		NextTurn()
	
	CalcFrame()
	DrawFrame()

func NextTurn():
	TurnTimeLeft = TurnTime
	if yourChoiceId == 1:
		nowaLokacja()
		return
	room.resourceCnt -= 1
	room.enemyTime -= 1

func nowaLokacja():
	room = rooms[rng.randi_range(0, len(rooms)-1)].duplicate()

func DrawFrame():
	textLabel.clear()
	textLabel.add_text("\n Widzisz " + room.name)
	textLabel.add_text("\n[" + str(room.resourceCnt) + "] " + room.resourceName)
	textLabel.add_text("\nNadciąga za " + str(room.enemyTime) + " " + room.enemyName)
	for id in range(len(choices)):
		var c = choices[id];
		var mark = " >> " if id == yourChoiceId else " -- "
		textLabel.add_text("\n" + mark + c)
	textLabel.add_text("\n" + "Time Left: " + str( (int) (TurnTimeLeft) ))

func CalcFrame():
	if Up && yourChoiceId > 0:
		yourChoiceId -= 1
	if Down && yourChoiceId + 1 < len(choices):
		yourChoiceId += 1
