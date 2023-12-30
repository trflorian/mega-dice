extends PanelContainer

@export var dice_container: DiceContainer
@export var submit_button: Button
@export var dice_name_edit: LineEdit

func _ready() -> void:
	submit_button.button_down.connect(submit_dice)
	dice_name_edit.text_submitted.connect(submit_dice)

func submit_dice():
	var name = dice_name_edit.text
	dice_name_edit.clear()
	dice_container.add_dice(name)
