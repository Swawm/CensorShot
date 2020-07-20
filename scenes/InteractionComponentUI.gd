extends Control
class_name InteractionComponentUI

export var interaction_component_nodepath : NodePath
export var interaction_text_nodepath : NodePath
export var interaction_default_text : String

var fixed_position : Vector2

func _ready():
	get_node(interaction_component_nodepath).connect("on_interactable_changed", self, "interactable_target_changed", [], CONNECT_DEFERRED)
	hide()
	
func _process(delta: float):
	set_global_position(fixed_position)
	
func interactable_target_changed(newInteractable: Node) -> void:
	if (newInteractable == null):
		hide()
		return
		
	var interaction_text := interaction_default_text
	if (newInteractable.has_method("interaction_get_text")):
		interaction_text = newInteractable.interaciton_get_text()
		
	fixed_position = Vector2(newInteractable.get_global_position().x, newInteractable.get_global_position().y - 50)
	self.set_global_position(fixed_position)
	
	show()
