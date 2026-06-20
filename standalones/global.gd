extends Node

signal state_changed(new_state: States)

enum States {
	START,
	BEGINNING_CUTSCENE,
	GAME,
	END_WIN,
	END_LOSS,
}

var state: States = States.START :
	set(val):
		if val == state: return
		state = val
		state_changed.emit(val)
var menu_manager: PixelMenuManager
