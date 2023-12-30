extends PanelContainer

class_name DiceContainer

#@export var scene_edit_dice: PackedScene
@export var dice_prefab: PackedScene

@onready var dice_container_parent: Control = %Dices

func _ready() -> void:
	_update_dices()

func add_dice(name: String):
	var dice_config = DiceConfig.new()
	dice_config.dice_name = name
	dice_config.dice_dots = [0, 0, 0, 0, 0, 0]
	
	Dice.dices.append(dice_config)
	_update_dices()

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
