extends Node2D

@export var faltasStart: int
var faltas: float
var faltasCartel: Label

var clasesSalteadas = [false, false, false, false, false]
var currentClase: int
var currentMateria: int

func _ready():
	faltas = faltasStart
	faltasCartel = $Faltas
	cambiarFaltas(0)
	
	#clases[0] = 
	#materias[0] = 0
	#clases[1] = 
	
	currentClase = -1
	Dialogic.signal_event.connect(_on_dialogic_signal)
	

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
		clasesSalteadas[clase] = estudiada > 0
		
		if(clasesSalteadas[clase]):
			print("Falto a " + str(clase))
	print(clasesSalteadas)
	

func _on_terminar_pressed():
	if Dialogic.current_timeline == null:
		Dialogic.start("res://clases/Clases.dtl")
	

func _on_dialogic_signal(argument:String):
	print(str(argument) + " " + str(currentClase))
	
	if argument == "finClase":
		for i in range(currentClase, clasesSalteadas.size()):
			currentClase += 1
			if currentClase < clasesSalteadas.size():
				if clasesSalteadas[currentClase] == false:
					break
			else:
				break
			
		Dialogic.VAR.nextClase = currentClase
		
		if currentClase >= clasesSalteadas.size():
			currentClase = -1
	
