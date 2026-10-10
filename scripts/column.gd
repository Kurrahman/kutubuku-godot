extends Node2D

@export var tile_scene: PackedScene
@export var row: int = 7
@export var tile_height: int = 64

signal tile_clicked()

var stack: Array[Area2D] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init_column(row: int) -> void:
	self.row = row
	fill_column()

func fill_column() -> void:
	spawn_tile(self.row - len(self.stack))

func spawn_tile(n :int = 1) -> void:
	if (len(stack) < self.row):
		for i in n:
			var start_y = -(tile_height * (self.row + i))
			var end_y = -(tile_height * (len(stack)))
			var new_tile = tile_scene.instantiate()
			self.stack.append(new_tile)
			new_tile.position.y = start_y
			new_tile.tile_clicked.connect(_on_tile_clicked)
			add_child(new_tile)
			new_tile.move_to(end_y)

func collapse_column():
	for i in len(stack):
		self.stack[i].move_to(-(tile_height * i))

func remove_tile(tile):
	if tile not in stack: return
	self.stack.remove_at(self.stack.find(tile))
	tile.queue_free()

func empty_column():
	for i in range(len(self.stack)):
		var tile = self.stack.pop_back()
		tile.queue_free()
		

func _on_tile_clicked(tile):
	tile_clicked.emit(tile)
