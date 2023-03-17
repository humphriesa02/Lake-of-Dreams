extends PlayerState

enum FishingState {
	AimingState = 0,
	WindingState = 1,
	CastingState = 2,
	WaitingForBiteState = 3,
	FishOnState = 4,
	FishCaughtState = 5
}

var local_state = 0 # 0 - aim, 1 - wind up cast (power), 2 - cast out, 3-waiting for a bite, 4 = fish on the hook, 5 = fish is caught
var target_fishing_location = Vector2.ZERO
var cast_distance_percentage = 0
var flipped = false;

func enter(msg := {}) -> void:
	player.animation_state.travel("Fishing")
	CursorManager.get_node("AnimatedSprite2D").play("fishing_green")
	CursorManager.get_node("AnimatedSprite2D").scale = Vector2(1, 1)

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("alt_action"): # Cancel fishing
		state_machine.transition_to("PlayerMovementState")
	match local_state: #Handle state input
		FishingState.AimingState:
			if Input.is_action_just_pressed("action"):
				target_fishing_location = player.get_global_mouse_position()
				CursorManager.movable = false
				local_state = FishingState.WindingState
		FishingState.WindingState:
			if Input.is_action_just_released("action"):
				local_state = FishingState.CastingState
		FishingState.CastingState:
			pass
		FishingState.WaitingForBiteState:
			pass
		FishingState.FishOnState:
			pass
		FishingState.FishCaughtState:
			pass

func update(delta: float) -> void:
	match local_state:
		FishingState.AimingState:
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
					
					
		FishingState.WindingState: # Increment and decrement the power bar
			if cast_distance_percentage < 1 and not flipped:
				cast_distance_percentage += delta
			elif cast_distance_percentage > 0 and flipped:
				cast_distance_percentage -= delta
			if cast_distance_percentage >= 1 and not flipped:
				flipped = true
			elif cast_distance_percentage <= 0 and flipped:
				flipped = false
				
				
		FishingState.CastingState:
			pass
			
			
		FishingState.WaitingForBiteState:
			pass
			
			
		FishingState.FishOnState:
			pass
			
			
		FishingState.FishCaughtState:
			pass
		
		
func move_to_pos(pos, speed):
	
	#Unit vector pointing at the target position from the characters position
	var direction = player.global_position.direction_to(pos)
	
	velocity = direction * speed
	move_and_slide()
