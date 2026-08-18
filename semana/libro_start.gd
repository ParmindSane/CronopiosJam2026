extends Node2D

@export var cantidadTotal: int
var cantidadActual: int

@export var materia: int
var libroRef = preload("res://semana/libro.tscn")
var libros: Array

func _ready():
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
		if new_occupant.materia == materia:
			new_occupant.queue_free()
			addLibro()
	
