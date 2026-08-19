extends Area2D

var materia: int
var sprite: Sprite2D

signal libroAgarrado(libro: Sprite2D)

func _ready():
	sprite = $Sprite2D
	

func setMateria(num:int):
	materia = num
	sprite.self_modulate = Color.from_hsv(Global.map(num, 1,3, 120,360)/360, 1,1)
	

func _on_draggable_drag_started(area):
	emit_signal("libroAgarrado", self)
	
