class_name InteractComponent
extends Area2D

signal interaction
signal stop_interact
signal throw_signal

@export var pickupable : bool

# intitiate an interaction like to open a shop, pickup something, change a switch
func interact(_user: Node2D):
	interaction.emit()

# once entered into a state of interaction to close said interaction like closing a shop or menu
func stop_interaction(_user: Node2D):
	push_warning("Not Implemented")
	stop_interact.emit()

# once obj is held to drop/throw obj based on player inputs
func throw(_user: Node2D):
	push_warning("Not Implemented")
	throw_signal.emit()
