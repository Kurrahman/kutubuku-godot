extends Node2D


var columns = []
var column_heights = [7,8,7,8,7,8,7]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	columns = get_children()
	for i in len(columns):
		columns[i].init_column(column_heights[i])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for column in columns:
		column.fill_column()
