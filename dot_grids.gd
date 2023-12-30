extends GridContainer

class_name DotGrids

@export var circle_texture: Texture2D
@export var dot_count: int = 0

var dots: Array[TextureRect]

func _ready() -> void:
	for child in get_children():
		dots.append(child)

func _process(delta: float) -> void:
	for i in range(Dice.ALL_DOTS):
		var dot = dots[i]
		var show_dot = (i < dot_count)
		dot.texture = circle_texture if show_dot else null
