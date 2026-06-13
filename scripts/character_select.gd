extends Control

var selected_character: String = ""

func _ready():
	var gm = get_node("/root/GameManager") as GameManager
	if gm:
		pass

func _on_character_selected(character: String):
	selected_character = character
	
	# Pick random opponent
	var opponents = ["gajahmada", "nagasamudra", "garudasinghasari", "kerisemas"]
	opponents.erase(character)
	var opponent = opponents[randi() % opponents.size()]
	
	var gm = get_node("/root/GameManager") as GameManager
	if gm:
		# Check if we came from story mode
		if gm.current_state == GameManager.GameState.STORY:
			# Go to story mode with this character
			gm.selected_character = character
			get_tree().change_scene_to_file("res://scenes/story_mode.tscn")
			return
		
		# Arcade mode: start fight
		gm.start_fight(character, opponent)
		get_tree().change_scene_to_file("res://scenes/fight_arena.tscn")
	else:
		# Fallback without GameManager
		get_tree().change_scene_to_file("res://scenes/fight_arena.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
