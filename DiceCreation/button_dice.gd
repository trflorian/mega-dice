extends Button

@onready var dot_grids: DotGrids = %GridContainer
@export var dice_creation: DiceCreation

var dice_index: int

func _ready() -> void:
	button_down.connect(_on_add_dot)
	
	dice_index = int(str(name)[-1]) - 1
	
	var initial_dots = Dice.editing_dice.dice_dots[dice_index]
	for i in range(initial_dots):
		add_dot()

func _on_add_dot():
	if Input.is_action_pressed("decrease"):
		remove_dot()
	else:
		add_dot()

func add_dot():
	if dice_creation.remaining_dots > 0 and dot_grids.dot_count < Dice.ALL_DOTS:
		dot_grids.dot_count += 1
		dice_creation.remaining_dots -= 1
		Dice.editing_dice.dice_dots[dice_index] = dot_grids.dot_count

func remove_dot():
	if dot_grids.dot_count > 0:
		dot_grids.dot_count -= 1
		dice_creation.remaining_dots += 1
		Dice.editing_dice.dice_dots[dice_index] = dot_grids.dot_count
