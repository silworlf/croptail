extends NodeState

@export var player: Player
@export var animated_sprite_2d : AnimatedSprite2D


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	 # 根据方向播放对应的动画
	if player.player_direction == Vector2.UP:
		animated_sprite_2d.play("idle_back")
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite_2d.play("idle_right")
	elif player.player_direction == Vector2.LEFT:
		animated_sprite_2d.play("idle_left")
	elif player.player_direction == Vector2.DOWN:
		animated_sprite_2d.play("idle_front")
	else:
		animated_sprite_2d.play("idle_front")
	
func _on_next_transitions() -> void:
	GameImputEvents.movement_imput()
	
	if GameImputEvents.is_movement_input():
		transition.emit("Walk")
	
	if player.current_tool  == DataTypes.Tools.AxeWood && GameImputEvents.use_tool():
		transition.emit("chopping")
		
	if player.current_tool  == DataTypes.Tools.TillGround && GameImputEvents.use_tool():
		transition.emit("tilling")
		
	if player.current_tool  == DataTypes.Tools.WaterCrops && GameImputEvents.use_tool():
		transition.emit("watering")

func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
