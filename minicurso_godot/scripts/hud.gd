extends Control

func update_hud(player):
	$ProgressBar.max_value = player.hpMax
	$ProgressBar.value = player.hp
	$Coins_Label.text = "Coins: " + str(player.coins)
