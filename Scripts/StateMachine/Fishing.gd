extends PlayerState


func enter(msg := {}) -> void:
	player.animation_state.travel("Fishing")

func handle_input(_event: InputEvent) -> void:
	# Grab input from our registered input maps
	#player.input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	if Input.is_action_just_pressed("alt_action"):
		state_machine.transition_to("Movement")

func physics_update(delta: float) -> void:
	print(get_viewport().get_mouse_position().normalized() - player.position.normalized())
	player.animation_tree.set("parameters/Fishing/blend_position", get_viewport().get_mouse_position().normalized() - player.position.normalized())
	pass
