extends Node2D

var introTerminada = false

func _ready():
	Dialogic.VAR.reset()

func _on_jugar_pressed():
	if !introTerminada:
		Dialogic.start("res://menu/intro/intro.dtl")
		Dialogic.signal_event.connect(introSignal)
	
func introSignal(argument:String):
	if argument == "finIntro":
		get_tree().change_scene_to_file("res://semana/semana.tscn")
	elif argument == "startIntro":
		$SkipIntro.show()
	
func _on_skip_pressed():
	introSignal("finIntro")
	Dialogic.end_timeline(true)

func _on_salir_pressed():
	get_tree().quit()
	
