extends CharacterBody2D
@export var SPEED = 300.0
#@export var JUMP_VELOCITY = -400.0

var hud = null
var hpMax = 100
@export var hp = 100

@export var atkdmg = 10
var isDead = false
var isAttk = false
var coins = 0

func _ready() -> void:
	hud = get_tree().current_scene.get_node("CanvasLayer/HUD")

func add_coins(amount: int):
	coins += amount
	hud.update_hud(self)

func knockback(direction: Vector2):
	velocity = (direction - velocity) * 1000
	move_and_slide()

# italo@supergeeks.com.br
# Para ataque é melhor processar frame a frame


func main_attack() -> void:
	$AnimatedSprite2D.play("atk")
	Area2D.process_mode = Node.PROCESS_MODE_INHERIT
	Area2D.process_mode = Node.PROCESS_MODE_DISABLED

func take_damage(damage: float):
	if isDead == false:
		isDead = true
		$AnimatedSprite2D.play("hit")
		hp-=damage
		hud.update_hud(self)
		$AnimatedSprite2D.modulate = Color(0.5, 0, 0)
		await get_tree().create_timer(1).timeout
		isDead = false
		$AnimatedSprite2D.modulate = Color(1, 1, 1)
	if hp <= 0:
		if isDead == false:
			isDead = true
			$AnimatedSprite2D.play("dead")
			await get_tree().create_timer(3).timeout
			$AnimatedSprite2D.play("death")
			OS.delay_msec(1000)
			get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	# Verificar is attk and ...
	if isDead == false:
		if direction.x != 0 or direction.y !=0:
			if direction.x < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
				
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")
		velocity = direction.normalized()*SPEED
		move_and_slide()
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "HitBox":
		area.get_parent().take_damage(atkdmg) # Replace with function body.
