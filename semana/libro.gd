extends Area2D

var id: int
var materia: int

var sprite: AnimatedSprite2D
var audios: Array[AudioStreamPlayer]

var ogScale: Vector2
var posInicial: Vector2

func _ready():
	sprite = $Sprite2D
	sprite.flip_h = [true, false].pick_random()
	
	audios.push_back($SonidoAgarrar)
	audios.push_back($SonidoColocar)
	
	ogScale = scale
	mouse_entered.connect(hoverOn)
	mouse_exited.connect(hoverOff)
	

func setMateria(_materia:int, _id: int, pi: Vector2):
	id = _id
	materia = _materia
	sprite.play("materia" + str(materia))
	
	posInicial = pi
	position = posInicial
	

func _on_draggable_drag_started(area):
	audios[0].play(0)
func _on_draggable_drag_ended(area, drop_spot):
	audios[1].play(0)
	

func hoverOn():
	scale = ogScale * 1.1
func hoverOff():
	scale = ogScale
