extends Node2D

var enemy = preload("res://scenes/slime.tscn")
func _on_timer_timeout() -> void:
	var slimes = enemy.instantiate()
	get_tree().root.add_child(slimes)
	slimes.position = global_position
