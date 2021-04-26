extends Control

const InputResponce = preload ("res://scenes/InputResponce.tscn")

var max_scroll_length := 0 

export (int) var max_lines_remembered := 30

onready var history_rows = $Background/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/GameInfo/ScrollContainer
onready var command_processor = $CommandProcessor
onready var scrollbar = scroll.get_v_scrollbar()


func _on_Input_text_entered(new_text: String):
	if new_text.empty():
		return
	if new_text == "clear":
		max_lines_remembered = 0
		delete_history_beyond_limit()
		max_lines_remembered = 30
	new_text = new_text.to_lower()
	var input_responce = InputResponce.instance()
	var responce = command_processor.process_command(new_text)
	input_responce.set_text(new_text, responce)
	history_rows.add_child(input_responce)
	delete_history_beyond_limit()
	
func _ready():
	scrollbar.connect("changed", self, "hande_scrollbar_changed")
	var input_responce = InputResponce.instance()
	input_responce.set_text("hello.sh", "Welcome to LFS terminal." + "\n" + "Print help for more info" + "\n" + "Don't forget to leave feedback at" + "\n" + "'http://34.73.15.119/'")
	history_rows.add_child(input_responce)
	max_scroll_length = scrollbar.max_value
	
func hande_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = scrollbar.max_value

func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
