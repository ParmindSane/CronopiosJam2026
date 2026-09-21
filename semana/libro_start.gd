extends Node2D

@export var cantidadTotal: int
var cantidadActual: int

@export var materia: int
var libroRef = preload("res://semana/libro.tscn")
var libros: Array

@export var rangoSpawn: float
var randoms: RandomNumberGenerator

func _ready():
	randoms = RandomNumberGenerator.new()
	
	for i in range(cantidadTotal):
		addLibro(i, Vector2(0,0))
	

func addLibro(i: int, pi: Vector2):
	var libroNuevo = libroRef.instantiate()
	libros.push_back(libroNuevo)
	add_child(libroNuevo)
	
	if pi == Vector2(0,0):
		var xMap = Global.map(i, 0,cantidadTotal-1, -1, +1)
		var yMap = Global.map(xMap, -1,+1, 0,1)
		var posRandom = randoms.randf_range(0, 1)*rangoSpawn
		pi = Vector2(xMap*140+posRandom*2, -yMap*rangoSpawn-posRandom)
	
	libroNuevo.setMateria(materia, i, pi)
	

func _on_drop_zone_drop_applied(zone, area, plan):
	if area.materia == materia:
		addLibro(area.id, area.posInicial)
		area.queue_free()
