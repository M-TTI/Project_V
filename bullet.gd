extends Area2D

var direction = Vector2(1.0,0.0)
var speed = 600

func _physics_process(delta):
	position = position + speed * direction * delta
	print(position)

func _on_Bullet_body_entered(body):
	if body.is_in_group("enemy"):
		body.queue_free()
	queue_free()
