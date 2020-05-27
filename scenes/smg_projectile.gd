extends Area2D



const BULLET_SPEED = 200
var motion = Vector2(1, 0) * BULLET_SPEED	

onready var bullet = $Sprite

func _ready():
	set_process(true)
	Player.connect("smg_picked_up", self, "_on_smg_picked_up")

	
func _physics_process(delta):
	position = position + motion * delta 
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.


func _on_smg_projectile_body_entered(_body):
	queue_free()
	pass # Replace with function body.
	

