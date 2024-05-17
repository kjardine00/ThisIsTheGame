extends Node2D

class_name HealthComponent

signal hurt
signal death

@export var MAX_HEALTH := 3

var health : float

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH

func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= 0:
		death.emit()
	else:
		print(str(get_parent().name) + "'s health is " + str(health))
		hurt.emit()
