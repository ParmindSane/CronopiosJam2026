extends Area2D

var id: int
var materia: int
var sprite: Sprite2D

signal libroAgarrado(libro: Sprite2D)

func _ready():
	sprite = $Sprite2D
	

func setMateria(_materia:int, _id: int):
	id = _id
	materia = _materia
	sprite.self_modulate = Color.from_hsv(Global.map(materia, -1,3, 40,360)/360, 1,1)
	

func _on_draggable_drag_started(area):
	emit_signal("libroAgarrado", self)
	
