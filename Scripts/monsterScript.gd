extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var chase = true
var dm = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var player = $"../Player/Player"
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	var pos = Vector3()
	pos.z = global_position.z
	var Player = $"../Player/Player"
	var direction = (Player.position - self.position).normalized()
	if chase:
		velocity.z = direction.z * SPEED
	else:
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()



#func _on_area_3d_2_body_entered(body):
	#var platforms = get_tree().get_nodes_in_group("Platforms")
	#for i in platforms:
		#if body.name in i.get_name():
			#velocity.y = JUMP_VELOCITY*2


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		player._change_health(dm)
