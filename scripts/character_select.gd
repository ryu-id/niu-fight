extends Control

var selected_character: String = ""

func _on_character_selected(character: String):
	selected_character = character
	# For now, always fight against a random opponent
	var opponents = ["gajahmada", "nagasamudra", "garudasinghasari", "kerisemas"]
	opponents.erase(character)
	var opponent = opponents[randi() % opponents.size()]
	
	# Store selection in a global way (simple for now)
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.start_fight(character, opponent)
	
	get_tree().change_scene_to_file("res://scenes/fight_arena.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")