extends CharacterBody2D

class_name Player

@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_component = $AttackComponent
@onready var health_component = $HealthComponent
@onready var animation_player = $AnimationPlayer
@onready var hurt_sfx = $HurtSFX

const SPEED = 130
const JUMP_VELOCITY = -290

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health

func _ready():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction:L -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")

	# Play Animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
			#animation_player.play("idle")
			pass
		else:
			animated_sprite.play("run")
			#animation_player.play("run")

	#flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump")
		#animation_player.play("jump")

func _on_health_component_hurt():
	#Play hurt anim, sound and handle hurt gamefunction
	animation_player.play("hurt")
	print("play hurt anim")
	# add invincibility for a brief momment

func _on_health_component_death():
		#Play death anim, sound and handle death gamefunction
	animation_player.play("death")

func bounce():
	velocity.y = JUMP_VELOCITY * 0.5
