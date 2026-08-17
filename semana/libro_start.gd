extends Area2D

@export var cantidad: int
@export var libroRef: Area2D
var libros: Array

func _ready():
	libroRef = $Libro
	
	for i in range(cantidad):
		var libroNuevo = libroRef.duplicate()
		libros.push_back(libroNuevo)
		add_child(libroNuevo)
		libroNuevo.position = Vector2(0,0)
	
