extends Node2D

var faltasStart: float = 5
var faltas: float

var horasDeEstudio: Array

func _ready():
	faltas = faltasStart
	

func cambiarFaltas(cambio: float):
	faltas += cambio
	

func _on_hora_estudiando(materia, clase, estudiada):
	estudiando(materia, clase, estudiada)
func _on_hora_2_estudiando(materia, clase, estudiada):
	estudiando(materia, clase, estudiada)
func _on_hora_3_estudiando(materia, clase, estudiada):
	estudiando(materia, clase, estudiada)
func estudiando(materia, clase, estudiada):
	print(str(materia) + " " + str(clase) + " " + str(estudiada))
