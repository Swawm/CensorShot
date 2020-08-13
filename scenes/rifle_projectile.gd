extends Area2D

const BULLET_SPEED = 300
var motion = Vector2(1, 0) * BULLET_SPEED	

func _ready():
	set_process(true)
	
	
func _physics_process(delta):
	position = position + motion * delta 
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_smg_projectile_body_entered(_body):
	queue_free()

