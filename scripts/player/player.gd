extends CharacterBody2D

class_name Player

@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_component = $AttackComponent
@onready var health_component = $HealthComponent
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
@onready var grab_position = $GrabPosition

const SPEED = 130
const JUMP_VELOCITY = -290

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health
var direction

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction:L -1, 0, R 1
	direction = Input.get_axis("move_left", "move_right")

	# Play Idle and Run Animations
	if is_on_floor() && animation_player.current_animation != "hurt":
		if direction == 0:
			animation_player.play("idle")
			pass
		else:
			animation_player.play("run")

	#flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
		grab_position.position.x = 8
	elif direction < 0:
		animated_sprite.flip_h = true
		grab_position.position.x = -8

	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("jump")

func _on_health_component_hurt():
	#Play hurt anim, sound and handle hurt gamefunction
	animation_player.play("hurt")
	# add invincibility for a brief momment

func _on_health_component_death():
	#Play death anim, sound and handle death gamefunction
	animation_player.play("death")

func bounce():
	velocity.y = JUMP_VELOCITY * 0.5
	
func knockback():
	velocity.y = JUMP_VELOCITY * 0.5
	velocity.x = JUMP_VELOCITY * 1.5

