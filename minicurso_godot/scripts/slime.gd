extends CharacterBody2D
@export var SPEED = 150.0
var player = null
var collision = null

func _ready() -> void:
	player = get_tree().get_nodes_in_group("Protagonists")[0]

func _physics_process(delta: float) -> void:
	velocity = global_position.direction_to(player.global_position).normalized()
	#direction.x = Input.get_axis("ui_left", "ui_right")
	#direction.y = Input.get_axis("ui_up", "ui_down")
	collision = get_last_slide_collision()
	if velocity.x != 0:
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
		$AnimatedSprite2D.play("move")
	else:
		$AnimatedSprite2D.play("idle")
	
	if collision:
		$AnimatedSprite2D.play("oppress")
	move_and_collide(velocity*SPEED*delta)
	move_and_slide()
