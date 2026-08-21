extends Node2D

func _on_jugar_pressed():
	#get_tree().change_scene_to_file("res://menu/intro/intro.tscn")
	Dialogic.start("res://menu/intro/intro.dtl")
	Dialogic.signal_event.connect(terminarIntro)
	
func terminarIntro(argument:String):
	if argument == "finIntro":
		get_tree().change_scene_to_file("res://semana/semana.tscn")
	

func _on_salir_pressed():
	get_tree().quit()
	
