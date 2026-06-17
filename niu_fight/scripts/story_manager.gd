extends Node
class_name StoryManager

var current_chapter: int = 0
var character_stories = {
	"gajahmada": [
		{"text": "Gajah Mada berdiri di Candi Borobudur. Ia bersumpah akan menyatukan Nusantara.", "opponent": "nagasamudra"},
		{"text": "Lawan pertama: Naga Samudra dari Srivijaya. Pertarungan di pelabuhan.", "opponent": "nagasamudra"},
		{"text": "Kemenangan! Gajah Mada melanjutkan perjalanan.", "opponent": "garudasinghasari"},
		{"text": "Final: Garuda Singhasari. Pertarungan epik di Gunung Merapi.", "opponent": "garudasinghasari"}
	],
	"nagasamudra": [
		{"text": "Naga Samudra bangkit dari lautan Srivijaya. Ia ingin melindungi laut.", "opponent": "gajahmada"},
		{"text": "Lawan pertama: Gajah Mada. Pertarungan di Candi Borobudur.", "opponent": "gajahmada"},
		{"text": "Kemenangan! Naga Samudra melanjutkan.", "opponent": "kerisemas"},
		{"text": "Final: Keris Emas di Hutan Suci.", "opponent": "kerisemas"}
	],
	"garudasinghasari": [
		{"text": "Garuda Singhasari terbang tinggi. Ia mencari keadilan.", "opponent": "kerisemas"},
		{"text": "Lawan pertama: Keris Emas. Pertarungan di Hutan.", "opponent": "kerisemas"},
		{"text": "Kemenangan! Garuda melanjutkan.", "opponent": "nagasamudra"},
		{"text": "Final: Naga Samudra di Pelabuhan Srivijaya.", "opponent": "nagasamudra"}
	],
	"kerisemas": [
		{"text": "Keris Emas berdiri di istana Mataram. Ia ingin melindungi kerajaan.", "opponent": "garudasinghasari"},
		{"text": "Lawan pertama: Garuda Singhasari.", "opponent": "garudasinghasari"},
		{"text": "Kemenangan! Keris Emas melanjutkan.", "opponent": "gajahmada"},
		{"text": "Final: Gajah Mada di Candi Borobudur.", "opponent": "gajahmada"}
	]
}

func get_story_for_character(character: String) -> Array:
	if character_stories.has(character):
		return character_stories[character]
	return []

func get_next_opponent(character: String, chapter: int) -> String:
	var story = get_story_for_character(character)
	if chapter < story.size():
		return story[chapter]["opponent"]
	return "gajahmada"