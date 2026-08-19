extends Node2D

@export var faltasStart: int
var faltas: float
var faltasCartel: Label

var horasDeEstudio: Array

func _ready():
	faltas = faltasStart
	faltasCartel = $Faltas
	cambiarFaltas(0)
	

func cambiarFaltas(cambio: int):
	faltas += cambio
	faltasCartel.text = "Quedan " + str(int(faltas)) + " faltas"
	

func _on_hora_estudiando(materia, clase, estudiada):
	estudiando(materia, clase, estudiada)
func _on_hora_2_estudiando(materia, clase, estudiada):
	estudiando(materia, clase, estudiada)
func _on_hora_3_estudiando(materia, clase, estudiada):
	estudiando(materia, clase, estudiada)
func estudiando(materia, clase, estudiada):
	print(str(materia) + " " + str(clase) + " " + str(estudiada))
	
	if clase >= 0:
		cambiarFaltas(-estudiada)

func _on_terminar_pressed():
	pass # Replace with function body.
