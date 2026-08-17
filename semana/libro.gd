extends Area2D

var materia: int

var draggable: Draggable
var dragId: String

var sprite: Sprite2D

signal libroAgarrado(libro: Sprite2D)

func _ready():
	sprite = $Sprite2D
	draggable = $Draggable
	

func setMateria(num:int):
	materia = num
	draggable.type.id = "materia" + str(materia)
	dragId = draggable.type.id
	print("soy " + dragId)
	
	sprite.self_modulate = Color.from_hsv(Global.map(num, 1,3, 120,360)/360, 100,100)
	

func _on_draggable_drag_started(area):
	print(draggable.type.id)
	emit_signal("libroAgarrado", self)
	
