extends PlayerState


func enter(msg := {}) -> void:
	player.animation_state.travel("Fishing")

func handle_input(_event: InputEvent) -> void:
	# Grab input from our registered input maps
	#player.input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	if Input.is_action_just_pressed("alt_action"):
		state_machine.transition_to("PlayerMovementState")

func update(delta: float) -> void:
	if abs(get_viewport().get_mouse_position().x - player.position.x) > abs( get_viewport().get_mouse_position().y - player.position.y): # X is farther
		if get_viewport().get_mouse_position().x >  player.position.x:
			player.animation_tree.set("parameters/Fishing/blend_position", Vector2(1, 0))
		elif get_viewport().get_mouse_position().x <  player.position.x:
			player.animation_tree.set("parameters/Fishing/blend_position", Vector2(-1, 0))
	else:
		if get_viewport().get_mouse_position().y >  player.position.y:
			player.animation_tree.set("parameters/Fishing/blend_position", Vector2(0, 1.1))
		elif get_viewport().get_mouse_position().y <  player.position.y:
			player.animation_tree.set("parameters/Fishing/blend_position", Vector2(0, -1.1))
	pass
