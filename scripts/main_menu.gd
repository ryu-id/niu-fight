extends Control

func _on_arcade_pressed():
	get_tree().change_scene_to_file("res://scenes/character_select.tscn")

func _on_story_pressed():
	get_tree().change_scene_to_file("res://scenes/character_select.tscn")

func _on_training_pressed():
	get_tree().change_scene_to_file("res://scenes/training.tscn")

func _on_exit_pressed():
	get_tree().quit()