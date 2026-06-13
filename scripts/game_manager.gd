extends Node
class_name GameManager

enum GameState { MAIN_MENU, CHARACTER_SELECT, FIGHTING, STORY, TRAINING, GAME_OVER }

var current_state: GameState = GameState.MAIN_MENU
var selected_character: String = ""
var opponent_character: String = ""
var player_wins: int = 0
var opponent_wins: int = 0
var current_round: int = 1

signal state_changed(new_state)
signal round_ended(winner)

func change_state(new_state: GameState):
	current_state = new_state
	emit_signal("state_changed", new_state)

func start_fight(player_char: String, opponent_char: String):
	selected_character = player_char
	opponent_character = opponent_char
	player_wins = 0
	opponent_wins = 0
	current_round = 1
	change_state(GameState.FIGHTING)

func end_round(winner: String):
	if winner == "player":
		player_wins += 1
	else:
		opponent_wins += 1
	
	emit_signal("round_ended", winner)
	
	if player_wins >= 2 or opponent_wins >= 2:
		change_state(GameState.GAME_OVER)
	else:
		current_round += 1
		# Reset for next round

func reset_game():
	player_wins = 0
	opponent_wins = 0
	current_round = 1
	change_state(GameState.MAIN_MENU)