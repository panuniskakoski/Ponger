extends KinematicBody2D

# Constant for pads speed
const PAD_SPEED = 10
var velocity: = Vector2(0, 10)

# Handles physics
func _physics_process(delta: float) -> void:
	var direction: = Vector2(
		0.0,
		Input.get_action_strength("left_down") - Input.get_action_strength("left_up")
	)
	velocity = PAD_SPEED * direction
	move_and_collide(velocity)
