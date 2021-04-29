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
			SimpleSave.load_scene(get_tree(), "res://save_slots/snapshot0.tscn")
			return "okay"
		"how":
			return "You dont have friends, do you?"
		"clear":
			return ""
		'docker':
			return "docker is not installed on this system"
		'ls':
			return 'open_door.sh' + "\n" + 'hello.sh' + "\n" + 'show_logs.sh'
		'./hello.sh':
			return "Welcome to LFS terminal." + "\n" + "Print help for more info" + "\n" + "Don't forget to leave feedback at" + "\n" + "http://34.73.15.119/"
		'./show_logs.sh':                                                                                                                                                                                           
			return "It rains in Hapros. To be honest," + "\n" + "I don't now how we can win against Alandor's" + "\n" + "army of the dead. Seems to me, there is no" + "\n" + "escape in this war, but just wait until" + "\n" + "you will become one of them"
	if first_word != "help":
		return "Error"
