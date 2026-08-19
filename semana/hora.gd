extends Area2D

@export var clase: int

signal estudiando(materia: int, clase: int, estudiada: int)

func _on_drop_zone_occupant_changed(zone, spot, old_occupant, new_occupant):
	var materiaEstudiada
	var hayLibroColocado
	
	if new_occupant != null:
		materiaEstudiada = new_occupant.materia
		hayLibroColocado = +1
	else:
		materiaEstudiada = old_occupant.materia
		hayLibroColocado = -1
	
	estudiando.emit(materiaEstudiada, clase, hayLibroColocado)
	
