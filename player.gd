extends Area2D

# 玩家与敌人碰撞时，发出这个信号
signal hit

var screen_size
var speed = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	screen_size = get_viewport_rect().size
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * 10
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta * 10
	position = position.clamp(Vector2.ZERO,screen_size)
	
	if velocity.x !=0:
		$AnimatedSprite2D.animation = 'walk'
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = 'up'
		$AnimatedSprite2D.flip_v = velocity.y > 0

	


func _on_body_entered(body: Node2D) -> void:
	hide() # Replace with function body.
	hit.emit()
	$CollisionShape2D.disabled = true
	
func start(pos) -> void:
	position = pos
	show()
	$CollisionShape2D.disabled = false
