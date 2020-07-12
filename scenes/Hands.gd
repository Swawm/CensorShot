extends Node2D

const SMG_PROJECTILE_SCENE = preload("res://scenes/smg_projectile.tscn")
const RIFLE_PROJECTILE_SCENE = preload("res://scenes/rifle_projectile.tscn")

var gun_id = 'hands'
onready var gun_sprite = get_node("Sprite")
onready var timer = get_node("Timer")

var bullets = 0

var guns = {}

# warning-ignore:unused_argument
func _process(_delta):
	change_gun()
	reload()


func change_gun():
	if Input.is_action_just_pressed("smg_choose"):
		gun_sprite.set_texture(load("res://sprites/hands/smg.png"))
		gun_id = 'smg'
		bullets = 32
		timer.set_wait_time(0.1)
	elif Input.is_action_just_pressed("rifle_choose"):
		gun_sprite.set_texture(load("res://sprites/hands/rifle.png"))
		gun_id = 'rifle'
		bullets = 5
		timer.set_wait_time(0.9)
	elif Input.is_action_just_pressed("hands_choose"):
		gun_id = 'hands'
		gun_sprite.set_texture(null)


func reload():
	if Input.is_action_just_pressed("reload_gun"):
		if gun_id == 'smg':
			bullets = 32 
		elif gun_id == 'rifle':
			bullets = 5
	return bullets
	
func create_projectile():
	var projectile
	if gun_id == 'smg':
		projectile = SMG_PROJECTILE_SCENE.instance()
	elif gun_id == 'rifle':
		projectile = RIFLE_PROJECTILE_SCENE.instance()
	get_tree().get_root().get_node("World").get_node("Player").get_parent().add_child(projectile)
	projectile.position = get_node("Sprite/Position2D").get_global_position()
	projectile.rotation_degrees = gun_sprite.get_rotation_degrees()
	projectile.get_node("Bullet_sprite").flip_h = false
	return projectile

func shoot():
	var body = get_tree().get_root().get_node("World").get_node("Player").get_node("Body")
	if gun_id != 'hands':
		if bullets > 0:
			bullets -= 1
			var projectile = create_projectile()
			get_tree().get_root().get_node("World").get_node("Player").get_node("walk").play()
			if body.flip_h == false:
				if gun_sprite.rotation_degrees == 45:
					projectile.motion = Vector2(1, 1) * projectile.BULLET_SPEED
				elif gun_sprite.rotation_degrees == -45:
					projectile.motion = Vector2(1, -1) * projectile.BULLET_SPEED
				elif gun_sprite.rotation_degrees == -90:
					projectile.motion = Vector2(0, -1) * projectile.BULLET_SPEED
				elif gun_sprite.rotation_degrees == 90:
					projectile.motion = Vector2(0, 1) * projectile.BULLET_SPEED
			elif body.flip_h == true: 
				projectile.get_node("Bullet_sprite").flip_h = true
				if gun_sprite.rotation_degrees == 45:
					projectile.motion = Vector2(-1, -1) * projectile.BULLET_SPEED
				elif gun_sprite.rotation_degrees == -45:
					projectile.motion = Vector2(-1, 1) * projectile.BULLET_SPEED
				elif gun_sprite.rotation_degrees == -90:
					projectile.motion = Vector2(0, 1) * projectile.BULLET_SPEED
				elif gun_sprite.rotation_degrees == 90:
					projectile.motion = Vector2(0, -1) * projectile.BULLET_SPEED
				else:
					projectile.motion = Vector2(-1, 0) * projectile.BULLET_SPEED
