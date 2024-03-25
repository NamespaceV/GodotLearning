extends Node2D

func _ready():
    $Sprite2D.modulate = Color.from_hsv(randf(),1,1)

func _process(_delta):
    # print("multiUid= ", multiplayer.get_unique_id()," authority= ",get_multiplayer_authority()," isAuth= ",is_multiplayer_authority()," name= ",name)
    if not is_multiplayer_authority(): return
    position  = get_global_mouse_position()

