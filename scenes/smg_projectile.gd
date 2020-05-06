extends Area2D

const FIREBALL_SPEED = 200
var motion = Vector2(1, 0) * FIREBALL_SPEED	

onready var player = $"/root/Player"


func _ready():
	set_process(true)
	
	
func _physics_process(delta):
	position = position + motion * delta 
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
