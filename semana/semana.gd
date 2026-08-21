extends Node2D

@export var faltasStart: int
var faltas: float
var faltasCartel: Label

var clasesSalteadas: String
var currentSemana: int
@export var semanas: Array[HBoxContainer]

const examenes = [2, 0, 4, 1]
var examenesId: Array[int]

var fullEstudiados: String
var estudiados: Array[int]
const librosTotales = [8, 19, 3, 0, 14]

var irClaseButton: Button

func _ready():
	currentSemana = 0
	mostrarCalendarios(currentSemana)
	
	irClaseButton = $Terminar
	
	faltas = faltasStart + 1
	faltasCartel = $Faltas
	cambiarFaltas(true)
	
	for clase in examenes:
		var i = examenes.find(clase)
		examenesId.push_back(clase*2 + 14*i)
	
	for i in range(5):
		estudiados.push_back(0)
	
	Dialogic.signal_event.connect(_on_dialogic_signal)
	

func mostrarCalendarios(i: int):
	for s in semanas:
		var soyEse = semanas.find(s) == i
		var modo = Node.PROCESS_MODE_DISABLED
		if soyEse:
			modo = Node.PROCESS_MODE_INHERIT
		s.visible = soyEse
		s.process_mode = modo
	

func cambiarFaltas(estudio: bool):
	if !estudio:
		faltas += 1
	else:
		faltas -= 1

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
	print("-------------------------------")
	print(("Saqué " if !colocado else "Estudié ") + str(materia) + " en la casilla " + str(id) + " de clase " + str(clase))
	
	if clase >= 0:
		cambiarFaltas(colocado)
		if colocado:
			clasesSalteadas += str(clase)
		else:
			clasesSalteadas = clasesSalteadas.replace(str(clase), "")
		
		print(("Falto" if colocado else "Asisto") + " a " + str(clase))
	print("Faltando a " + str(clasesSalteadas))
	
	var i = examenes.find(materia)
	if id < examenesId[i]:
		if colocado:
			estudiados[materia] += 1
		else:
			estudiados[materia] -= 1
	if estudiados[materia] >= librosTotales[materia]:
		if ! str(materia) in fullEstudiados:
			fullEstudiados += str(materia)
	else:
		fullEstudiados = fullEstudiados.replace(str(materia), "")
	
	print("Vengo estudiando " + str(estudiados))
	print("Debo estudiar " + str(librosTotales))
	print("Terminé de estudiar " + fullEstudiados)
	

func _on_terminar_pressed():
	Dialogic.VAR.ausentes = clasesSalteadas
	Dialogic.VAR.examen = examenes[currentSemana]
	Dialogic.VAR.llegaBien = fullEstudiados
	
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
		else:
			mostrarCalendarios(currentSemana)
	
