extends KinematicBody2D

# Constant for pads speed
const PAD_SPEED = 10
var velocity: = Vector2(10, 0)

# Handles physics
func _physics_process(delta: float) -> void:
	var direction: = Vector2(
		Input.get_action_strength("left_right") - Input.get_action_strength("left_left"), 
		0.0
	)
	velocity = PAD_SPEED * direction
	move_and_collide(velocity)
