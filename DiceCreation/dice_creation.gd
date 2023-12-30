extends Control

class_name DiceCreation

@export var dice_overview: PackedScene
@export var label_dice_name: Label
@export var button_finish: Button
@export var remaining_dot_grid: DotGrids

var remaining_dots: int = Dice.ALL_DOTS

func _ready() -> void:
	label_dice_name.text = Dice.editing_dice.dice_name
	button_finish.button_down.connect(_on_finish_dice)

func _on_finish_dice() -> void:
	get_tree().change_scene_to_packed(dice_overview)

func _process(delta: float) -> void:
	remaining_dot_grid.dot_count = remaining_dots
