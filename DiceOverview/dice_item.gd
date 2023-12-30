extends HBoxContainer

class_name DiceItem

@export var label_name: Label
@export var button_edit: Button
@export var button_delete: Button

var dice_config: DiceConfig

signal on_edit
signal on_remove

func _ready() -> void:
	button_edit.button_down.connect(func(): on_edit.emit())
	button_delete.button_down.connect(func(): on_remove.emit())

func set_config(_dice_config: DiceConfig):
	dice_config = _dice_config
	label_name.text = dice_config.dice_name
