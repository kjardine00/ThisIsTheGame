extends Node

var coins = 0
var player_life = 3

func add_coin():
	coins +=1
	print(coins)

func player_hit():
	player_life -= 1
	if player_life == 0:
		pass
		
