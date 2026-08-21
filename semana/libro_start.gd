extends Node2D

@export var cantidadTotal: int
var cantidadActual: int

@export var materia: int
var libroRef = preload("res://semana/libro.tscn")
var libros: Array

var randoms: RandomNumberGenerator

func _ready():
	randoms = RandomNumberGenerator.new()
	
	for i in range(cantidadTotal):
		addLibro(i)
	

func addLibro(i: int):
	var libroNuevo = libroRef.instantiate()
	libros.push_back(libroNuevo)
	add_child(libroNuevo)
	
	var xMap = Global.map(i, 0,cantidadTotal-1, -1, +1)*140
	var posRandom = randoms.randf_range(-6, +6)
	libroNuevo.position = Vector2(xMap+posRandom, posRandom)
	
	libroNuevo.setMateria(materia, i)
	

func _on_drop_zone_drop_applied(zone, area, plan):
	if area.materia == materia:
		addLibro(area.id)
		area.queue_free()
