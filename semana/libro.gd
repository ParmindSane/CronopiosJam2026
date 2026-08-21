extends Area2D

var id: int
var materia: int
var sprite: AnimatedSprite2D
var audios: Array[AudioStreamPlayer]

var ogScale: Vector2

func _ready():
	sprite = $Sprite2D
	audios.push_back($SonidoAgarrar)
	audios.push_back($SonidoColocar)
	
	audios.push_back(AudioStream.new())
	audios.push_back("res://semana/assets/papelColocar.mp3")
	
	ogScale = scale
	mouse_entered.connect(hoverOn)
	mouse_exited.connect(hoverOff)
	

func setMateria(_materia:int, _id: int):
	id = _id
	materia = _materia
	sprite.play("materia" + str(materia))
	#sprite.self_modulate = Color.from_hsv(Global.map(materia, -1,3, 40,360)/360, 1,1)
	

func _on_draggable_drag_started(area):
	audios[0].play(0)
func _on_draggable_drag_ended(area, drop_spot):
	audios[1].play(0)
	

func hoverOn():
	scale = ogScale * 1.1
func hoverOff():
	scale = ogScale
