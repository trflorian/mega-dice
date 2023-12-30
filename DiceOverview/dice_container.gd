extends PanelContainer

class_name DiceContainer

#@export var scene_edit_dice: PackedScene
@export var dice_prefab: PackedScene

@onready var dice_container_parent: Control = %Dices

var save_path = "user://dices.save"

func _ready() -> void:
	if Dice.dices.is_empty():
		_load_dices()
	_update_dices()

func add_dice(name: String):
	var dice_config = DiceConfig.new()
	dice_config.dice_name = name
	dice_config.dice_dots = [0, 0, 0, 0, 0, 0]
	
	Dice.dices.append(dice_config)
	_update_dices()
	
	edit_dice(dice_config)

func remove_dice(dice_config: DiceConfig):
	Dice.dices.remove_at(Dice.dices.find(dice_config))
	_update_dices()

func edit_dice(dice_config: DiceConfig):
	Dice.editing_dice = dice_config
	get_tree().change_scene_to_file("res://DiceCreation/dice_creation.tscn")
	#get_tree().change_scene_to_packed(scene_edit_dice)

func _update_dices():
	for child in dice_container_parent.get_children():
		dice_container_parent.remove_child(child)
	
	for dice in Dice.dices as Array[DiceConfig]:
		var dice_inst = dice_prefab.instantiate() as DiceItem
		dice_container_parent.add_child(dice_inst)
		dice_inst.set_config(dice)
		dice_inst.on_remove.connect(remove_dice.bind(dice))
		dice_inst.on_edit.connect(edit_dice.bind(dice))
	_save_dices()

func _save_dices():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var dices_dict = {}
	for dice in Dice.dices as Array[DiceConfig]:
		dices_dict[dice.dice_name] = dice.dice_dots
	file.store_string(JSON.stringify(dices_dict))
	print("saved")

func _load_dices():
	if FileAccess.file_exists(save_path):
		print("save file found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		var dices_dict = JSON.parse_string(file.get_as_text()) as Dictionary
		for dice_name in dices_dict.keys():
			var dice_cfg = DiceConfig.new()
			dice_cfg.dice_name = dice_name
			dice_cfg.dice_dots = dices_dict[dice_name] as Array[int]
			Dice.dices.append(dice_cfg)
	else:
		print("no save file not found")
