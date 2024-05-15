extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_front = $RayCastFront
@onready var ray_cast_down = $RayCastDown
@onready var collision_box = $CollisionShape2D
@onready var killzone_collision = $Killzone/KillzoneCollision
@onready var animation_player = $AnimationPlayer

const JUMP_VELOCITY = -290
const WIDTH_FROM_CENTER = 7

var speed = 35
var direction = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Changes the direction of the sprite
func flip_direction():
	direction *= -1
	ray_cast_front.target_position.x = ray_cast_front.target_position.x * -1
	animated_sprite.flip_h = !animated_sprite.flip_h
	ray_cast_down.position.x = WIDTH_FROM_CENTER * direction

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle collision with walls and not falling off an edge
	if is_on_floor():
		if ray_cast_front.is_colliding() or not ray_cast_down.is_colliding():
			flip_direction()
	
	position.x += direction * speed * delta
	move_and_slide()
	
# Jumped on
func _on_hurtbox_body_entered(body):
	speed = 0
	animation_player.play("death")
	body.bounce()
	
