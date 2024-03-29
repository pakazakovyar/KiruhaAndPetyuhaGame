extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 30
var health = 5
var dam = 1
@onready var healthbar = $HealthBar
@onready var mesh = $hero
@onready var parts = $hero/CPUParticles3D
@onready var timer = $Timer
@onready var anim = $hero/AnimationPlayer

func _ready():
	health = 5
	healthbar.init_health(health)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
		

	var input_dir = Input.get_vector("up", "down", "right", "left")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if Input.is_action_just_pressed("left"):
		mesh.rotation.y = 0
	if Input.is_action_just_pressed("right"):
		mesh.rotation.y = 190 * delta
	if direction:
		velocity.z = direction.z * SPEED
		anim.play("run")
	else:
		anim.play("idle")
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if Input.is_action_just_pressed("shift"):
		velocity.z = direction.z * 20 * SPEED
		parts.emitting = true
		parts.gravity.z = direction.z
	elif Input.is_action_pressed("shift"):
		velocity.z = direction.z * 2 * SPEED
		anim.play("fastrun")
	if Input.is_action_just_released("shift"):
		parts.emitting = false
	move_and_slide()
	
	
func _change_health(value):
	healthbar.health -= value
	if healthbar.health == 0:
		die()

func die():
	get_tree().change_scene_to_file("res://Levels/level.tscn")

	


