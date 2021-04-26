extends VBoxContainer

func set_text(input: String, responce: String):
	$InputHistory.text = ' > ' + input
	$Responce.text = responce
	
