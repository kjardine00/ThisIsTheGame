extends RigidBody2D

@export var picked_up = false
@export var player : Player

var player_held_position

func _physics_process(delta):
	if (picked_up == true):
		#global position = position in the moment of the game not absolute position
		self.position = player_held_position.global_position
		
	if (picked_up == false):
		pass

func _on_interact_component_interaction():
	if player_held_position:
		picked_up = true

func _on_interact_component_throw_signal():
	if (picked_up == true):
		print(str(player) + "is throwing/dropping pot orange")
		if (player.direction == 0): 
			picked_up = false
		#picked_up = false
	
func _on_interact_component_body_entered(body):
	if (body is Player):
		player = body
		player_held_position = player.grab_position
		
