extends Node2D

signal word_submitted(word)

var columns = []
var column_heights = [7,8,7,8,7,8,7]
var selected_tiles = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	columns = get_children()
	for i in len(columns):
		columns[i].init_column(column_heights[i])
		columns[i].tile_clicked.connect(_on_tile_clicked)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_selected_word() -> String:
	var output = ''
	for t in selected_tiles:
		output += t.letter
	return output

func shake_selected_tiles():
	for tile in self.selected_tiles:
		tile.shake()

func remove_tile(tile):
	for column in self.columns:
		column.remove_tile(tile)

func fill_board():
	for column in self.columns:
		column.fill_column()

func collapse_board():
	for column in self.columns:
		column.collapse_column()

func empty_board():
	for column in self.columns:
		column.empty_column()

func reset_board():
	empty_board()
	fill_board()

func get_wait_duration():
	var max_tile_in_column = 0
	for column in columns:
		if (column.stack.back() in self.selected_tiles): continue
		var n = column.stack.reduce(
			func(accum, tile): 
				return accum + (1 if tile in self.selected_tiles else 0),
			0
		)
		if (n > max_tile_in_column): max_tile_in_column = n
	return max_tile_in_column * 0.1

func remove_submitted_word():
	var duration = get_wait_duration()
	for t in self.selected_tiles:
		remove_tile(t)
		self.selected_tiles = []
		collapse_board()
	await get_tree().create_timer(duration).timeout
	fill_board()

func unselect_all_tiles():
	for t in self.selected_tiles:
		t.unselect()
	self.selected_tiles = []

func submit_word():
	var word = get_selected_word()
	if not Dict.word_lookup(word):
		shake_selected_tiles()
		return
	word_submitted.emit(word)
	remove_submitted_word()

func _on_tile_clicked(tile):
	if !self.selected_tiles.is_empty():
		# theres already selected tiles
		var last_tile = self.selected_tiles.back()
		if last_tile == tile:
			# click on last tile
			submit_word()
			return
		elif not tile.is_selected and not last_tile.is_neighbor(tile):
			unselect_all_tiles()
			return
				
	if (tile not in selected_tiles):
		tile.select()
		self.selected_tiles.append(tile)
	else:
		var idx = self.selected_tiles.find(tile) + 1
		for i in range(len(self.selected_tiles) - idx):
			self.selected_tiles[idx].unselect()
			self.selected_tiles.remove_at(idx)


func _on_shuffle_pressed() -> void:
	reset_board()
