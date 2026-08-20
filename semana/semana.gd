extends Node2D

@export var faltasStart: int
var faltas: float
var faltasCartel: Label

var clasesSalteadas: String
var currentSemana: int

const examenes = [2, 0, 4, 1]
var examenesId: Array

var fullEstudiados: String
var estudiados: Array
const librosTotales = [8, 19, 3, 0, 14]

var irClaseButton: Button

func _ready():
	currentSemana = 0
	
	irClaseButton = $Terminar
	
	faltas = faltasStart
	faltasCartel = $Faltas
	cambiarFaltas(0)
	
	for clase in examenes:
		var i = examenes.find(clase)
		examenesId.push_back(clase*2 + 14*i)
	
	Dialogic.signal_event.connect(_on_dialogic_signal)
	

func cambiarFaltas(estudio: bool):
	var cambio = +1 if estudio else -1
	
	faltas += cambio
	if faltas >= 0:
		faltasCartel.label_settings.font_color = Color(1.0, 1.0, 1.0, 1.0)
		irClaseButton.disabled = false
		faltasCartel.text = "Quedan " + str(int(faltas)) + " faltas"
	else:
		faltasCartel.label_settings.font_color = Color(1,0,0)
		irClaseButton.disabled = true
	

func _on_hora_estudiando(materia, clase, colocado, id):
	estudiando(materia, clase, colocado, id)
func _on_hora_2_estudiando(materia, clase, colocado, id):
	estudiando(materia, clase, colocado, id)
func estudiando(materia, clase, colocado, id):
	print("Saqué " if !colocado else "Estudié " + str(materia) + " en la casilla " + str(id) + " de clase " + str(clase))
	
	if clase >= 0:
		cambiarFaltas(colocado)
		if colocado:
			clasesSalteadas += str(clase)
		else:
			clasesSalteadas.replace(str(clase), "")
		
		print("Falto" if colocado else "Asisto" + " a " + str(clase))
	print(clasesSalteadas)
	
	var i = examenes.find(materia)
	if id < examenesId[i]:
		if colocado:
			estudiados[materia] += 1
		else:
			estudiados[materia] -= 1
	

func _on_terminar_pressed():
	var currentExamen = examenes[currentSemana]
	
	Dialogic.VAR.ausentes = clasesSalteadas
	Dialogic.VAR.examen = currentExamen
	
	if estudiados[currentExamen] >= librosTotales[currentExamen]:
		Dialogic.VAR.llegaBien = true
	
	if Dialogic.current_timeline == null:
		Dialogic.start("res://clases/Clases.dtl")
	

func _on_dialogic_signal(argument:String):
	if argument == "finde":
		clasesSalteadas = ""
		currentSemana += 1
		
		if currentSemana >= 4:
			if Dialogic.VAR.goodEnding:
				get_tree().change_scene_to_file("res://menu/endings/good_ending.tscn")
			else:
				get_tree().change_scene_to_file("res://menu/endings/bad_ending.tscn")
	
