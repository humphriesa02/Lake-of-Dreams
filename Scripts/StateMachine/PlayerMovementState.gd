extends PlayerState

# changing variables
var input_direction = Vector2.ZERO

func enter(msg := {}) -> void:
	input_direction = Vector2.ZERO
	player.velocity = Vector2.ZERO
	CursorManager.get_node("AnimatedSprite2D").play("default")
	CursorManager.get_node("AnimatedSprite2D").scale = Vector2(0.25, 0.25)

func handle_input(_event: InputEvent) -> void:
	# Grab input from our registered input maps
	input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	if Input.is_action_just_pressed("action"):
		state_machine.transition_to("PlayerFishingState")

func update(delta: float) -> void:
	# If we have input
	if input_direction != Vector2.ZERO:
		player.animation_tree.set("parameters/Idle/blend_position", input_direction)
		player.animation_tree.set("parameters/Walk/blend_position", input_direction)
		player.animation_state.travel("Walk")
		# Have our velocity approach our speed in the direction of our input, using acceleration
		player.velocity = player.velocity.move_toward(input_direction * player.speed, player.accel * delta)
	else:
		player.animation_state.travel("Idle")
		# Have velocity approach zero using the friction variable
		player.velocity = player.velocity.move_toward(Vector2.ZERO, player.frict * delta)
	player.move_and_slide()
	
