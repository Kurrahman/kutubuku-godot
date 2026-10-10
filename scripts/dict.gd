extends Node

const DICTIONARY_PATH = 'res://assets/dictionary/dictionary.txt'
var dictionary:  Array[String] = []
var dictionary_length = 0

func load_dictionary():
	var file = FileAccess.open(DICTIONARY_PATH, FileAccess.READ)
	if file != null:
		while not file.eof_reached():
			var line = file.get_line()
			self.dictionary.append(line.to_upper())
	self.dictionary_length = len(self.dictionary)


func word_lookup(word: String) -> bool:
	if self.dictionary_length < 1: return false
	var left = 0 
	var right = self.dictionary_length
	while left != right:
		var middle = (left + right) / 2
		if (middle == left): break
		if word < self.dictionary[middle]:
			right = middle - 1
		elif word > self.dictionary[middle]:
			left = middle + 1
		else: return true
	return word == self.dictionary[left]
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_dictionary()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
