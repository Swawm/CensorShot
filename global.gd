extends Node

var save_path = SAVE_DIR + "save.dat"
const SAVE_DIR = "user://Saves/"

func save_state():
	var data = Player.save()
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
		
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, _File.WRITE, "ololo")
	if error == OK:
		file.store_var(data)
		file.close()

func load_state():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, _File.READ)
		if error == OK:
			var player_data = file.get_var()
			file.close()
			
	pass
	
