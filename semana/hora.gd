extends Area2D

@export var clase: int
@export var id: int
@export var examen: bool

signal estudiando(materia: int, clase: int, estudiada: int)

func _ready():
	setExamen(examen, id)
	

func setExamen(_soy: bool, _id: int):
	examen = _soy
	if examen:
		process_mode = Node.PROCESS_MODE_DISABLED
	else:
		process_mode = Node.PROCESS_MODE_INHERIT
	
	id = _id
	$Label.text = str(id) + str("\n examen" if examen else "")
	

func _on_drop_zone_occupant_changed(zone, spot, old_occupant, new_occupant):
	var materiaEstudiada
	var hayLibroColocado
	
	if new_occupant != null:
		materiaEstudiada = new_occupant.materia
		hayLibroColocado = true
	else:
		materiaEstudiada = old_occupant.materia
		hayLibroColocado = false
	
	estudiando.emit(materiaEstudiada, clase, hayLibroColocado, id)
	
