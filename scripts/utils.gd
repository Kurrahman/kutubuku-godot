extends Node

var randomizer = RandomNumberGenerator.new()
var letter_groups = [
	['A', 'E', 'I', 'R', 'N', 'K', 'M', 'T', 'U', 'G'],
	['B', 'S', 'D', 'H', 'L', 'O', 'P', 'C', 'J', 'Y'],
	['F', 'Q', 'V', 'W', 'X', 'Z']
]

var group_index_distribution = [0,0,0,0,0,1,1,1,2]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func random_letter() -> String:
	return self.letter_groups[self.group_index_distribution.pick_random()].pick_random()
