extends Area2D

signal tile_clicked()
var letter
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.letter = Utils.random_letter()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			tile_clicked.emit(self)
		

func move_to(y: int):
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(self.position.x, y), 0.2)
