extends CanvasLayer

@export var empty_cursor: Texture

var movable = true;
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(empty_cursor, Input.CURSOR_ARROW)
	$AnimatedSprite2D.play("default");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if movable:
		$AnimatedSprite2D.global_position = $AnimatedSprite2D.get_global_mouse_position()
