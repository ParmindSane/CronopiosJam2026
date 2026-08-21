extends TextureButton

var ogScale: Vector2
func _ready():
	ogScale = offset_transform_scale
	mouse_entered.connect(hoverOn)
	mouse_exited.connect(hoverOff)
	

func hoverOn():
	offset_transform_scale = ogScale * 1.1
func hoverOff():
	offset_transform_scale = ogScale
