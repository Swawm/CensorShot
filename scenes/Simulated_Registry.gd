extends Node

var registry = {"test" : "this", "player" : "Swawm", "PI" : PI, "DATE" : OS.get_datetime(), "SYSTEM" : OS.get_name() }

func lookup(name : String):
	if registry.has(name):
		return registry[name]
	else:
		return ""
