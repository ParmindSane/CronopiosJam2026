extends Area2D

var sprite: Sprite2D
@export var color: Color

func _ready():
	sprite = $Sprite2D
	sprite.self_modulate = color
	
