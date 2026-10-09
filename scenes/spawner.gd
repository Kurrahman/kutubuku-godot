extends Node2D

@export var tile_scene : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_exited(body: Node2D) -> void:
	print(body)
	var tile = tile_scene.instantiate()
	add_child(tile)
