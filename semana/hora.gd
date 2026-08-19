extends Area2D

@export var clase: int

signal estudiando(materia: int, clase: int, estudiada: int)

var colShape: CollisionShape2D
func _ready():
	colShape = $CollisionShape2D
	colShape.debug_color = Color.from_hsv(Global.map(clase, -1,3, 40,360)/360, 1,1)

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
	
