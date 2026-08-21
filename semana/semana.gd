extends Node2D

@export var faltasStart: int
var faltas: float
@export var faltasCartel: Node

@export var fechasCarteles: Array[Sprite2D]
@export var numSemanaCartel: AnimatedSprite2D

var clasesSalteadas: String
var currentSemana: int
@export var semanas: Array[HBoxContainer]

const examenes = [2, 0, 4, 1]
var examenesId: Array[int]
var examenesNodos: Array[Node]
@export var marcaExamen: Sprite2D

var fullEstudiados: String
var estudiados: Array[int]
const librosTotales = [8, 19, 3, 0, 14]

@export var irClaseButton: BaseButton

@export var musiquita: AudioStreamPlayer

func _ready():
	currentSemana = 0
	
	for clase in examenes:
		var i = examenes.find(clase)
		examenesId.push_back(clase*2 + 14*i)
	
	for i in range(5):
		estudiados.push_back(0)
	
	for i in range(0, 4):
		var horaId = 0 + 14*i
		
		var s
		if i>0:
			s = semanas[i-1].duplicate()
			semanas.push_back(s)
			add_child(s)
		else:
			s = semanas[i]
		
		var dias = s.get_children()
		for d in dias:
			var horas = d.get_children()
			for h in horas:
				h.connect("estudiando", estudiando)
				
				var esExamen = horaId in examenesId
				if esExamen:
					examenesNodos.push_back(h)
				
				h.setExamen(esExamen, horaId)
				horaId += 1
	
	mostrarCalendarios(currentSemana)
	
	faltas = faltasStart + 1
	cambiarFaltas(true)
	
	Dialogic.signal_event.connect(_on_dialogic_signal)
	

func mostrarCalendarios(i: int):
	for s in semanas:
		var soyEse = semanas.find(s) == i
		var modo = Node.PROCESS_MODE_DISABLED
		if soyEse:
			modo = Node.PROCESS_MODE_INHERIT
		s.visible = soyEse
		s.process_mode = modo
	
	marcaExamen.reparent(examenesNodos[i], false)
	marcaExamen.visible = true
	
	numSemanaCartel.play("semana" + str(i+1))
	
	if i > 0:
		fechasCarteles[i-1].visible = true
	
	musiquita.play(0)
	

func cambiarFaltas(estudio: bool):
	if !estudio:
		faltas += 1
	else:
		faltas -= 1

	if faltas >= 0:
		faltasCartel.text = str(int(faltas))
		faltasCartel.label_settings.font_color = Color(0.0, 0.0, 0.0, 1.0)
		irClaseButton.disabled = false
		irClaseButton.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		faltasCartel.label_settings.font_color = Color(1,0,0)
		irClaseButton.disabled = true
		irClaseButton.self_modulate = Color(1.0, 0.0, 0.0, 0.588)
	

#func _on_hora_estudiando(materia, clase, colocado, id):
	#estudiando(materia, clase, colocado, id)
#func _on_hora_2_estudiando(materia, clase, colocado, id):
	#estudiando(materia, clase, colocado, id)
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
	
	musiquita.stop()
	
	if Dialogic.current_timeline == null:
		Dialogic.start("res://clases/Clases.dtl")
	

func _on_dialogic_signal(argument:String):
	if argument == "finde":
		clasesSalteadas = ""
		currentSemana += 1
		
		if currentSemana >= 4:
			Dialogic.start("res://menu/endings/ending.dtl")
			#if Dialogic.VAR.goodEnding:
				#get_tree().change_scene_to_file("res://menu/endings/good_ending.tscn")
			#else:
				#get_tree().change_scene_to_file("res://menu/endings/bad_ending.tscn")
		else:
			mostrarCalendarios(currentSemana)
	
