extends Control

class_name DiceCreation

@export var remaining_dot_grid: DotGrids

var remaining_dots: int = Dice.ALL_DOTS

func _process(delta: float) -> void:
	remaining_dot_grid.dot_count = remaining_dots
