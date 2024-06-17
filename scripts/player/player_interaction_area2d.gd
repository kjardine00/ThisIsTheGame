extends Area2D

@export var interactor : Node2D
@export var interation_action : StringName = "interact"

var selected_interactable : InteractComponent
var nearby_interactables : Array[InteractComponent]
var player_holding = false


func _input(event: InputEvent):
	# interact is pressed
	if(event.is_action_pressed(interation_action)):
		# check if there is an interactable available
		if(selected_interactable != null):
			# if the player isn't holding something then interact with the obj
			if (player_holding == false):
				selected_interactable.interact(interactor)
				if (selected_interactable.pickupable == true):
					player_holding = true
			# if the player is holding something hold/drop said obj
			elif (player_holding == true):
				selected_interactable.throw(interactor)
				player_holding = false

func _on_area_entered(area : Area2D):
	if (area is InteractComponent):
		nearby_interactables.push_back(area)
		
		if (selected_interactable  == null):
			selected_interactable = nearby_interactables[0]

func _on_area_exited(area : Area2D):
	if (area is InteractComponent):
		nearby_interactables.erase(area)
		
		selected_interactable.stop_interaction(interactor)
		
		if (nearby_interactables.size() > 0):
			selected_interactable = nearby_interactables[0]
