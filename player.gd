extends Area2D

@export var speed = 400
var screen_size

signal hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

func shoot(mouse_position):
	var direction = mouse_position-position
	var bullet = load("bullet.tscn").instantiate()
	bullet.direction = direction.normalized()
	bullet.position = position
	bullet.look_at(mouse_position)
	add_child(bullet)
	bullet.set_as_top_level(true) 



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed('move_left'):
		velocity.x += -1
	if Input.is_action_pressed('move_up'):
		velocity.y += -1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
	if Input.is_action_just_pressed('shoot'):
		var mouse_position = get_global_mouse_position()
		shoot(mouse_position)
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	


func _on_body_entered(body: Node2D) -> void:
	print('hit')
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
