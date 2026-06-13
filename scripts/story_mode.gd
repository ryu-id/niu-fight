extends Control

@onready var chapter_label: Label = $ChapterLabel
@onready var story_text: RichTextLabel = $StoryText

var current_character: String = "gajahmada"
var current_chapter: int = 0
var story_manager: StoryManager

func _ready():
	# Get selected character from GameManager
	var gm = get_node("/root/GameManager") as GameManager
	if gm and gm.selected_character != "":
		current_character = gm.selected_character
	else:
		current_character = "gajahmada"
	
	story_manager = StoryManager.new()
	add_child(story_manager)
	
	show_current_chapter()

func show_current_chapter():
	var stories = story_manager.get_story_for_character(current_character)
	if current_chapter < stories.size():
		var chapter_data = stories[current_chapter]
		chapter_label.text = "BAB " + str(current_chapter + 1)
		story_text.text = "[center]" + chapter_data["text"] + "\n\nLawan: " + chapter_data["opponent"] + "[/center]"
	else:
		story_text.text = "[center]✨ Kamu telah menyelesaikan semua cerita! ✨\n\nNusantara telah bersatu![/center]"
		chapter_label.text = "TAMAT"
		$ContinueButton.text = "KEMBALI KE MENU"

func _on_continue_pressed():
	var stories = story_manager.get_story_for_character(current_character)
	if current_chapter < stories.size():
		var chapter_data = stories[current_chapter]
		var opponent = chapter_data["opponent"]
		
		# Set GameManager for fight
		var gm = get_node("/root/GameManager") as GameManager
		if gm:
			gm.start_fight(current_character, opponent)
		
		get_tree().change_scene_to_file("res://scenes/fight_arena.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
