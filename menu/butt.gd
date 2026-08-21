extends TextureButton

var ogScale: Vector2
func _ready():
	offset_transform_enabled = true
	ogScale = offset_transform_scale
	mouse_entered.connect(hoverOn)
	mouse_exited.connect(hoverOff)
	

func hoverOn():
	if !disabled:
		offset_transform_scale = ogScale * 1.1
func hoverOff():
	if !disabled:
		offset_transform_scale = ogScale
