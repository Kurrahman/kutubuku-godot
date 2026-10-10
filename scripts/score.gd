extends VBoxContainer
var word_score = {
	"A": 50,
	"B": 150,
	"C": 150,
	"D": 100,
	"E": 50,
	"F": 200,
	"G": 100,
	"H": 200,
	"I": 50,
	"J": 400,
	"K": 250,
	"L": 50,
	"M": 150,
	"N": 50,
	"O": 50,
	"P": 150,
	"Q": 500,
	"R": 50,
	"S": 50,
	"T": 50,
	"U": 50,
	"V": 200,
	"W": 200,
	"X": 400,
	"Y": 200,
	"Z": 500,
}
var score: int = 0
@onready var score_text: Label = $Score

signal shuffle
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.score_text.text = '0'
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_multiplier(word) -> float:
	var n = len(word)
	match n:
		2: return 1.0
		3: return 1.0
		4: return 1.2
		5: return 1.5
		6: return 2
		7: return 3
		_: return 5
	
func calculate_word_score(word) -> int:
	var score = 0
	for c in word:
		score += self.word_score.get(c)
	return score * get_multiplier(word)
	

func _on_board_word_submitted(word: Variant) -> void:
	self.score += calculate_word_score(word)
	self.score_text.text = str(self.score)


func _on_shuffle_pressed() -> void:
	shuffle.emit()
