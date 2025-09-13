extends Node

@export var mob_scene: PackedScene

var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game() -> void:
	score = 0
	$Music.play()
	get_tree().call_group('mobs','queue_free')
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimner.start()


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	# 在路径上随机一个位置
	mob_spawn_location.progress_ratio = randf()
	# 将输出现的位置给到敌人
	mob.position = mob_spawn_location.position
	# 
	var direction = mob_spawn_location.rotation + PI/2
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
	


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timner_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
