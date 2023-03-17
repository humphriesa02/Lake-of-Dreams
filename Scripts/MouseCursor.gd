extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Input.set_custom_mouse_cursor(sprite_frames.get_frame_texture(animation, frame), Input.CURSOR_ARROW,
	Vector2(sprite_frames.get_frame_texture(animation, frame).get_height()/2, sprite_frames.get_frame_texture(animation, frame).get_width()/2)
