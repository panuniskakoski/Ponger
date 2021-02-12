extends Node2D

# Member variables
var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)

# Constant for ball speed (in pixels/second)
const INITIAL_BALL_SPEED = 80
# Speed of the ball (also in pixels/second)
var ball_speed = INITIAL_BALL_SPEED
# Constant for pads speed
const PAD_SPEED = 450

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("paddleLU").get_texture().get_size()
	set_process(true)

func _process(delta):
	var ball_pos = get_node("ball").position
	var left_up_rect = Rect2( get_node("paddleLU").position - pad_size*0.5, pad_size )
	var left_bottom_rect = Rect2( get_node("paddleLB").position - pad_size*0.5, pad_size )
	var right_up_rect = Rect2( get_node("paddleRU").position - pad_size*0.5, pad_size )
	var right_bottom_rect = Rect2( get_node("paddleRB").position - pad_size*0.5, pad_size )
	
	# Integrate new ball position
	ball_pos += direction * ball_speed * delta
	
	# Flip when touching roof or floor
	if ((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
		direction.y = -direction.y
		
	# Flip, change horizontal direction and increase speed when touching pads
	if ((left_up_rect.has_point(ball_pos) and direction.x < 0) or (right_bottom_rect.has_point(ball_pos) and direction.x > 0)):
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
		
	# Flip, change vertical direction and increase speed when touching pads
	if ((left_bottom_rect.has_point(ball_pos) and direction.y < 0) or (right_up_rect.has_point(ball_pos) and direction.y > 0)):
		direction.y = -direction.y
		direction.x = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
		
	# Check gameover if the ball leaves the screen
	if (ball_pos.x < 0 or ball_pos.x > screen_size.x):
		ball_pos = screen_size*0.5
		ball_speed = INITIAL_BALL_SPEED
		direction = Vector2(-1, 0)
		
	# Updates the ball position
	get_node("ball").set_position(ball_pos)
	
	# Move left upper paddle
	var left_upper_pos = get_node("paddleLU").position

	if (left_upper_pos.y > 0 and Input.is_action_pressed("left_up")):
		left_upper_pos.y += -PAD_SPEED * delta
	if (left_upper_pos.y < screen_size.y and Input.is_action_pressed("left_down")):
		left_upper_pos.y += PAD_SPEED * delta

	get_node("paddleLU").set_position(left_upper_pos)
	
	# Move left bottom paddle
	var left_bottom_pos = get_node("paddleLB").position

	if (left_bottom_pos.x > 0 and Input.is_action_pressed("left_left")):	# TÄÄLLÄ VIKA JOS Liikkuu PÄINVAASTOIN
		left_bottom_pos.x += -PAD_SPEED * delta
	if (left_bottom_pos.x < screen_size.x and Input.is_action_pressed("left_right")):
		left_bottom_pos.x += PAD_SPEED * delta

	get_node("paddleLB").set_position(left_bottom_pos)	

	# Move right bottom paddle
	var right_bottom_pos = get_node("paddleRB").position

	if (right_bottom_pos.y > 0 and Input.is_action_pressed("right_up")):
		right_bottom_pos.y += -PAD_SPEED * delta
	if (right_bottom_pos.y < screen_size.y and Input.is_action_pressed("right_down")):
		right_bottom_pos.y += PAD_SPEED * delta

	get_node("paddleRB").set_position(right_bottom_pos)
	
	# Move right upper paddle
	var right_upper_pos = get_node("paddleRU").position

	if (right_upper_pos.x > 0 and Input.is_action_pressed("right_left")):	# TÄÄLLÄ VIKA JOS Liikkuu PÄINVAASTOIN
		right_upper_pos.x += -PAD_SPEED * delta
	if (right_upper_pos.x < screen_size.x and Input.is_action_pressed("right_right")):
		right_upper_pos.x += PAD_SPEED * delta
		
	get_node("paddleRU").set_position(right_upper_pos)
