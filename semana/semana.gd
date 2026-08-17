extends Node2D

var faltasStart: float = 5
var faltas: float

var horasDeEstudio: Array

func _ready():
	faltas = faltasStart

func cambiarFaltas(cambio: float):
	faltas += cambio
