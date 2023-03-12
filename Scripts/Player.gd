extends CharacterBody2D

@export var speed = 100
@export var accel = 500
@export var frict = 500

var input_direction = Vector2.ZERO

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree


func _unhandled_input(event):
	# Grab input from our registered input maps
	input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	
func _physics_process(delta):
	# If we have input
	if input_direction != Vector2.ZERO:
		print(input_direction)
		animation_tree.set("parameters/Idle/blend_position", input_direction)
		animation_tree.set("parameters/Walk/blend_position", input_direction)
		# Have our velocity approach our speed in the direction of our input, using acceleration
		velocity = velocity.move_toward(input_direction * speed, accel * delta)
	else:
		animation_player.play("IdleRight")
		# Have velocity approach zero using the friction variable
		velocity = velocity.move_toward(Vector2.ZERO, frict * delta)
	move_and_slide()

