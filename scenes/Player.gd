extends KinematicBody2D 

const FRICTION = 0.25
const GRAVITY = 1000
const AIR_RESISTANCE = 0.02
const JUMP_FORCE = 250

var ACCELERATION = 200
var MAX_SPEED = 50
var motion = Vector2.ZERO
var sprint = 100

onready var body = $Body

onready var gun_sprite = $Body/Hands/Sprite
onready var gun = $Body/Hands
onready var animation = $Animation
onready var timer = get_node("Body/Hands/Timer")

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if x_input !=0:
		if Input.is_action_pressed("ui_run"):
			if gun.gun_id == 'hands':
				animation.play("Run_fast (hands)")
			else:
				animation.play("Run_fast")
			var ACCELERATION = 300
			var MAX_SPEED = 100
			motion.x += x_input * ACCELERATION * delta
			motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		else:
			if gun.gun_id == 'hands':
				animation.play("Run (hands)")
			else:
				animation.play("Run")
			motion.x += x_input * ACCELERATION * delta
			motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)

		body.flip_h = x_input < 0
		gun_sprite.flip_h = x_input < 0

		
		if body.flip_h == true:
			$Body/Hands/Sprite/Position2D.set_position(Vector2(-13.212, 2.443))
			gun_sprite.offset = Vector2(-4, 3)
			gun.position = Vector2(3, -2)
		else:
			gun_sprite.flip_v = false
			$Body/Hands/Sprite/Position2D.set_position(Vector2(13.212, 2.443))
			gun_sprite.offset = Vector2(4, 3)
			gun.position = Vector2(-3, -2)
			
			
	else: 
		if gun.gun_id == 'hands':
			animation.play("Idle (hands)")
		else:
			animation.play("Idle")
		 

	motion.y += GRAVITY * delta

	if is_on_floor():
		if x_input == 0 :
			motion.x = lerp(motion.x, 0, FRICTION)
		if Input.is_action_just_pressed("ui_jump"):
			motion.y = -JUMP_FORCE
			get_node("jump").play() 
	else: 
		if gun.gun_id == 'hands':
				animation.play("Jump (hands)")
		else:
			animation.play("Jump")
# warning-ignore:integer_division
		if Input.is_action_just_released("ui_jump") and motion.y < -JUMP_FORCE/2:
# warning-ignore:integer_division
			motion.y = -JUMP_FORCE/2
			
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
			
	if Input.is_action_pressed("ui_shoot"):
		if timer.is_stopped():
			gun.shoot()
			timer.start()

		
	motion = move_and_slide(motion, Vector2.UP)
	
	if body.flip_h == false:
		if Input.is_action_pressed("ui_gun_up") and Input.is_action_pressed("ui_gun_right"):
			gun_sprite.rotation_degrees = -45
		elif Input.is_action_pressed("ui_gun_down") and Input.is_action_pressed("ui_gun_right"):
			gun_sprite.rotation_degrees =45
		elif Input.is_action_pressed("ui_gun_down"):
			gun_sprite.rotation_degrees = 90
		elif Input.is_action_pressed("ui_gun_up"):
			gun_sprite.rotation_degrees = -90
		else: 
			gun_sprite.rotation_degrees = 0
	elif body.flip_h == true:
		if Input.is_action_pressed("ui_gun_up") and Input.is_action_pressed("ui_gun_left"):
			gun_sprite.rotation_degrees = 45
		elif Input.is_action_pressed("ui_gun_down") and Input.is_action_pressed("ui_gun_left"):
			gun_sprite.rotation_degrees = -45
		elif Input.is_action_pressed("ui_gun_down"):
			gun_sprite.rotation_degrees = -90
		elif Input.is_action_pressed("ui_gun_up"):
			gun_sprite.rotation_degrees = 90
		else: 
			gun_sprite.rotation_degrees = 0
