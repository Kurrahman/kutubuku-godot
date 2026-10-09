extends Node2D

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

func remove_tile(tile):
	for column in self.columns:
		column.remove_tile(tile)

func fill_board():
	for column in columns:
		column.fill_column()

func collapse_board():
	for column in self.columns:
		column.collapse_column()

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

func _on_tile_clicked(tile):
	var last_tile = self.selected_tiles.back()
	if last_tile == tile:
		var duration = get_wait_duration()
		for t in self.selected_tiles:
			remove_tile(t)
		collapse_board()
		await get_tree().create_timer(duration).timeout
		fill_board()
		return
		
	if last_tile != null and not tile.is_selected:
		if not last_tile.is_neighbor(tile):
			return
	
	if (tile not in selected_tiles):
		tile.select()
		self.selected_tiles.append(tile)
	else:
		var idx = self.selected_tiles.find(tile)
		for i in range(len(self.selected_tiles) - idx):
			self.selected_tiles[idx].unselect()
			self.selected_tiles.remove_at(idx)
