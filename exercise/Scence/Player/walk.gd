extends StateCommonCode




func enter()->void:
	player.animation_state.travel("walk")
	
	
func exit()->void:
	pass
	
func physics_update(delta:float)->void:
	player.apply_gravity(delta)
	player.velocity = player.move_and_slide_with_snap(player.velocity,
													  player.snap_vector,
													  Vector2.UP,
													  true,
													  4,
													  player.floor_max_angle,
													  false)

	var inputdirection_x:float =(
		Input.get_action_strength("right")-Input.get_action_strength("left")
	)
	if is_equal_approx(inputdirection_x,0.0):
		state_machine.transition_to("idle")
		return

	player.update_direction(inputdirection_x)
	player.velocity.x = player.walk_speed * inputdirection_x
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("jump")
		return
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("attack")
		return
		
