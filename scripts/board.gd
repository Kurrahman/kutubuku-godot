extends Node2D

var columns = []
var column_heights = [7,8,7,8,7,8,7]
var selected_word = ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	columns = get_children()
	for i in len(columns):
		columns[i].init_column(column_heights[i])
		columns[i].tile_clicked.connect(_on_tile_clicked)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for column in columns:
		column.fill_column()

func _on_tile_clicked(tile):
	selected_word += tile.letter
	print(selected_word)
