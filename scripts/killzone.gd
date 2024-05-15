extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	print(str(body) + "you died")
	body.get_node("AnimationPlayer").play("death")
	Engine.time_scale = 0.5
	timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
