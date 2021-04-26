extends Node

func process_command(input: String):
	var words = input.split(" ", false, 0)
	if words.size() == 0:
		return ("Error")
	var first_word = words[0]
	match first_word:
		"help":
			return "Print exit to leave" + '\n' + 'Print clear to clear screen output' + '\n' + 'Print ls to see directory content'
		"fuck":
			return "Do not be rude, please"
		"exit":
			get_tree().change_scene("res://levels/test2.tscn")
			return "okay"
		"how":
			return "You dont have friends, do you?"
		"clear":
			return ""
		'docker':
			return "docker is not installed on this system"
		'ls':
			return 'open_door.sh' + "\n" + 'hello.sh'
		'./hello.sh':
			return "Welcome to LFS terminal." + "\n" + "Print help for more info" + "\n" + "Don't forget to leave feedback at" + "\n" + "http://34.73.15.119/"
			
	if first_word != "help":
		return "Error"
