extends CharacterBody2D
@export var attk = 15.60
@export var SPEED = 150.0
var player = null
var collision = get_last_slide_collision()

var isDead = false;
var hp = 70
func take_damage(damage: float):
	hp -= damage
	if hp <= 0:
		queue_free()

func _ready() -> void:
	pass # player = get_tree().get_nodes_in_group("Protagonists")[0]

func _physics_process(delta: float) -> void:
	if player !=null:
		velocity = global_position.direction_to(player.global_position).normalized()
	#direction.x = Input.get_axis("ui_left", "ui_right")
	#direction.y = Input.get_axis("ui_up", "ui_down")
	if isDead == false:
		if velocity.x != 0:
			if velocity.x < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")
		move_and_collide(velocity*SPEED*delta)
		move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Protagonists"):
		player = body # Replace with function body.


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Protagonists"):
		if body.hp > 0:
			isDead = true
			body.isDead = true
			$AnimatedSprite2D.play("oppress")
			await get_tree().create_timer(1).timeout
			body.knockback(velocity)
			body.isDead = false
			body.take_damage(attk)
			$AnimatedSprite2D.play("idle")
			await get_tree().create_timer(1).timeout
			isDead = false
