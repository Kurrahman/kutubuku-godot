extends Node
var letter_dist= {
	"A": 14.492949,
	"B": 2.931469,
	"C": 0.912545,
	"D": 2.019922,
	"E": 10.593054,
	"F": 0.550071,
	"G": 4.662511,
	"H": 1.51226,
	"I": 7.148434,
	"J": 0.834961,
	"K": 5.594015,
	"L": 3.885425,
	"M": 5.468035,
	"N": 9.955171,
	"O": 3.491769,
	"P": 3.44936,
	"Q": 0.005239,
	"R": 6.242625,
	"S": 4.626338,
	"T": 4.828655,
	"U": 4.631078,
	"V": 0.191839,
	"W": 0.445545,
	"X": 0.007235,
	"Y": 0.797541,
	"Z": 0.09779
}
var randomizer = RandomNumberGenerator.new()
var letter_bucket: Array[String] = []

func fill_bucket():
	if not self.letter_bucket.is_empty(): return
	for i in range(65, 90):
		for _j in range(ceil(letter_dist.get(char(i)) * 10)):
			self.letter_bucket.append(char(i))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fill_bucket()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func random_letter() -> String:
	if self.letter_bucket.is_empty(): fill_bucket()
	return self.letter_bucket.pick_random()
