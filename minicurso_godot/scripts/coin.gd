extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var isDead = false
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Protagonists"): # Replace with function body.
		if isDead == false:
			$AnimatedSprite2D.play("acquire")
			#isDead = true
			body.add_coins(1)
			await get_tree().create_timer(4).timeout
			queue_free()
