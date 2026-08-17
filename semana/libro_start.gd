extends Area2D

@export var materia: int

@export var cantidadTotal: int
var cantidadActual: int

var libroRef = preload("res://semana/libro.tscn")
var libros: Array

@export var dropzone: DropZone
var dragId: String

func _ready():
	dragId = "materia" + str(materia)
	dropzone.accepted_draggable_types[0].id = dragId
	print(dropzone.accepted_draggable_types[0].id)
	
	for i in range(cantidadTotal):
		addLibro()
	

func addLibro():
		var libroNuevo = libroRef.instantiate()
		libros.push_back(libroNuevo)
		add_child(libroNuevo)
		libroNuevo.position = Vector2(0,0)
		libroNuevo.setMateria(materia)
	

func _on_drop_zone_occupant_changed(zone, spot, old_occupant, new_occupant):
	if new_occupant != null:
		new_occupant.queue_free()
		addLibro()
	

func _on_mouse_entered():
	print(dropzone.accepted_draggable_types[0].id)
