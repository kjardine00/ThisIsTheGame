extends Node2D

@export var is_on = false

@onready var animation_player = $AnimationPlayer

# signal the obj that needs to change as a result of toggling the switch
signal toggle_switch

func _ready():
	is_on = false

func _on_interact_component_interaction():
	is_on = not is_on
	if (is_on == true):
		animation_player.play("on")
		toggle_switch.emit()
	elif (is_on == false):
		animation_player.play("off")
		toggle_switch.emit()
