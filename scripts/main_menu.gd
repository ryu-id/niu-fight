extends Control

func _ready():
	var gm = get_node("/root/GameManager") as GameManager
	if gm:
		gm.change_state(GameManager.GameState.MAIN_MENU)

func _on_arcade_pressed():
	var gm = get_node("/root/GameManager") as GameManager
	if gm:
		gm.change_state(GameManager.GameState.CHARACTER_SELECT)
	get_tree().change_scene_to_file("res://scenes/character_select.tscn")

func _on_story_pressed():
	var gm = get_node("/root/GameManager") as GameManager
	if gm:
		gm.change_state(GameManager.GameState.STORY)
		# For story, we still need character select first
	get_tree().change_scene_to_file("res://scenes/character_select.tscn")

func _on_training_pressed():
	var gm = get_node("/root/GameManager") as GameManager
	if gm:
		gm.change_state(GameManager.GameState.TRAINING)
	get_tree().change_scene_to_file("res://scenes/training.tscn")

func _on_exit_pressed():
	get_tree().quit()
