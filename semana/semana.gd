extends Node2D

@export var faltasStart: int
var faltas: float
var faltasCartel: Label

var clasesSalteadas: Array
var examenes: Array
var currentClase: int
var currentMateria: int
var currentSemana: int

var irClaseButton: Button

func _ready():
	currentSemana = 0
	
	for i in range(5):
		clasesSalteadas.push_back(false)
	
	for i in range(4):
		var nuevaSemana = []
		for j in range(5):
			nuevaSemana.push_back(false)
		examenes.push_back(nuevaSemana)
	examenes[0][1] = true
	print(examenes)
	
	irClaseButton = $Terminar
	
	faltas = faltasStart
	faltasCartel = $Faltas
	cambiarFaltas(0)
	
	currentClase = -1
	Dialogic.signal_event.connect(_on_dialogic_signal)
	

func cambiarFaltas(cambio: int):
	faltas += cambio
	if faltas >= 0:
		faltasCartel.label_settings.font_color = Color(1.0, 1.0, 1.0, 1.0)
		irClaseButton.disabled = false
		faltasCartel.text = "Quedan " + str(int(faltas)) + " faltas"
	else:
		faltasCartel.label_settings.font_color = Color(1,0,0)
		irClaseButton.disabled = true
	

func _on_hora_estudiando(materia, clase, estudiada):
	estudiando(materia, clase, estudiada)
func _on_hora_2_estudiando(materia, clase, estudiada):
	estudiando(materia, clase, estudiada)
func estudiando(materia, clase, estudiada):
	print(str(materia) + " " + str(clase) + " " + str(estudiada))
	
	if clase >= 0:
		cambiarFaltas(-estudiada)
		clasesSalteadas[clase] = estudiada > 0
		
		if(clasesSalteadas[clase]):
			print("Falto a " + str(clase))
	print(clasesSalteadas)
	

func _on_terminar_pressed():
	if Dialogic.current_timeline == null:
		Dialogic.start("res://clases/Clases.dtl")
	

func _on_dialogic_signal(argument:String):
	print(str(argument) + " " + str(currentClase))
	
	if argument == "finClase":
		for i in range(currentClase, clasesSalteadas.size()):
			currentClase += 1
			if currentClase < clasesSalteadas.size():
				Dialogic.VAR.examen = examenes[currentSemana][currentClase]
				
				if clasesSalteadas[currentClase] == false:
					break
			else:
				break
			
		Dialogic.VAR.nextClase = currentClase
		
		if currentClase >= clasesSalteadas.size():
			currentClase = -1
			currentSemana += 1
		
		if currentSemana >= 4:
			if Dialogic.VAR.badEnding:
				get_tree().change_scene_to_file("res://menu/endings/bad_ending.tscn")
			else:
				get_tree().change_scene_to_file("res://menu/endings/good_ending.tscn")
	
