extends StaticBody2D

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player
	
func interaction_interact(interactionComponentParent : Node) -> void:
	SimpleSave.save_scene(get_tree(), "res://save_slots/snapshot0.tscn")
	get_tree().change_scene("res://scenes/Terminal.tscn")
	
func interaction_get_text() -> String:
	return "Terminal" 
