class_name PersonField
extends HBoxContainer

@onready var delete_button := $Delete


func _ready() -> void:
	delete_button.pressed.connect(_on_delete_button_pressed)


func _on_delete_button_pressed() -> void:
	queue_free()
