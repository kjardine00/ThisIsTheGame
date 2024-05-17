extends Area2D

@onready var timer = $Timer

# This Area2D when added to a level needs to be given a CollisionShape2D

func _on_body_entered(body):
	print(str(body) + " fell out throught the deathplane")
	#body.hurt_box()
	Engine.time_scale = 0.5
	timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
