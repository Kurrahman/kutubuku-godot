extends Area2D

signal tile_clicked()

@onready var sprite: Sprite2D = $Sprite
@onready var text: Label = $Sprite/Label
@onready var search_area: Area2D = $SearchArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var is_selected = false
var letter
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	self.letter = Utils.random_letter()
	self.text.text = self.letter


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shake() -> void:
	self.animation_player.play("shake")

func unselect():
	self.is_selected = false
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1, 1, 1, 1), 0.1)

func select():
	self.is_selected = true
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1.3, 1, 1.3, 1.0), 0.1)

func is_neighbor(tile) -> bool:
	var neighbors = $SearchArea.get_overlapping_areas()
	return tile in neighbors

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is not InputEventMouseButton:
		return
	if event.button_index == MOUSE_BUTTON_LEFT and event.pressed :
		tile_clicked.emit(self)

func move_to(y: int):
	var tween = create_tween()
	var duration = 0.1 * abs(self.position.y - y) / 128
	tween.tween_property(self, "position", Vector2(self.position.x, y), duration)
