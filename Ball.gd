extends KinematicBody2D

# Member variables
var screen_size
var direction = Vector2(1.0, 0.0)
var collider

# Constant for ball speed (in pixels/second)
const INITIAL_BALL_SPEED = 200
var velocity: = Vector2(INITIAL_BALL_SPEED, 0.0)
# Speed of the ball (also in pixels/second)
var ball_speed = INITIAL_BALL_SPEED

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
		velocity = velocity.bounce(collision.normal)




	
	
func _on_hitbox_collision(entity):
	collider = entity.get_parent()
	if (collider.is_in_group("paddle_vertical")):
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
			
	if (collider.is_in_group("paddle_horizontal")):
		direction.y = -direction.y
		direction.x = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
	
	
	


# If collision with vertical paddle


