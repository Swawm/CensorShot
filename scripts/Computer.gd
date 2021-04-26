extends StaticBody2D

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player
	
func interaction_interact(interactionComponentParent : Node) -> void:
	get_tree().change_scene("res://scenes/Terminal.tscn")
	pass
	
func interaction_get_text() -> String:
	return "Terminal" 
