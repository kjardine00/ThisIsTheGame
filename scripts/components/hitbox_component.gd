extends Area2D

class_name HitboxComponent

@export var health_component: HealthComponent

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)

func _on_body_entered(body):
	print(str(body) + " entered " + str(get_parent().name))
	if body.attack_component:
		damage(body.attack_component)
		
	if body.has_method("bounce"):
		body.bounce()

