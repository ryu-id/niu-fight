extends Control

@onready var chapter_label: Label = $ChapterLabel
@onready var story_text: RichTextLabel = $StoryText

var current_character: String = "gajahmada"
var current_chapter: int = 0
var story_manager: StoryManager

func _ready():
	story_manager = StoryManager.new()
	add_child(story_manager)
	
	# Get selected character from global or default
	current_character = "gajahmada"  # Can be changed from character select later
	
	show_current_chapter()

func show_current_chapter():
	var stories = story_manager.get_story_for_character(current_character)
	if current_chapter < stories.size():
		var chapter_data = stories[current_chapter]
		chapter_label.text = "CHAPTER " + str(current_chapter + 1)
		story_text.text = "[center]" + chapter_data["text"] + "[/center]"
	else:
		# Story finished
		story_text.text = "[center]Kamu telah menyelesaikan cerita![/center]"
		chapter_label.text = "SELESAI"

func _on_continue_pressed():
	var stories = story_manager.get_story_for_character(current_character)
	if current_chapter < stories.size():
		var opponent = stories[current_chapter]["opponent"]
		# Start fight
		get_tree().change_scene_to_file("res://scenes/fight_arena.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")