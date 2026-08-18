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
	

func _on_drop_zone_drop_applied(zone, area, plan):
	if area.materia == materia:
			area.queue_free()
			addLibro()
