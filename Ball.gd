extends KinematicBody2D

# Member variables
var screen_size

# Constant for ball speed (in pixels/second)
const INITIAL_BALL_SPEED = 300
var velocity: = Vector2(INITIAL_BALL_SPEED, 165.5)

# What is handled every frame
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	# If collision happens ball bounces
	if collision:
		velocity = velocity.bounce(collision.normal)
